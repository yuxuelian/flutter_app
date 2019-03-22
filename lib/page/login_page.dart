import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scan_access/http/request_method.dart';
import 'package:scan_access/main.dart';
import 'package:scan_access/store/user_store.dart';
import 'package:scan_access/widget/state_button.dart';
import 'package:scoped_model/scoped_model.dart';

import '../bean/index.dart';
import '../prefs/prefs_util.dart';
import '../utils/form_check.dart';
import 'web_view_page.dart';

/// 未登录显示的页面
class LoginPage extends StatefulWidget {
  /// 跳转到登录页面
  static Future<T> start<T extends Object>(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => MyApp.createTransition(animation, child),
        transitionDuration: Duration(milliseconds: 400),
        ),
      );
  }

  const LoginPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  // 倒计时总时长
  static const COUNT_DOWN = 60;
  var currentDownNum = COUNT_DOWN;

  /// true 密码登录   false 验证码登录
  var isPwdLoginMode = false;

  /// true显示密码    false  不显示密码
  var isShowPwd = false;

  /// 标记是否能够点击登录按钮
  var isEnableLogin = false;

  /// 获取验证码按钮显示的文本内容(默认为   获取验证码)
  var qrCodeBtnText = '获取验证码';

  /// 获取验证码按钮是否可用(默认  可用)
  var qrCodeBtnEnable = false;

  // 记录输入的手机号和验证码
  var phone = '';
  var authCode = '';

  // 用于记录是否正在倒计时
  var isCounting = false;

  /// 切换密码登录或者验证码登录
  void _changeLoginMode() {
    setState(() {
      isPwdLoginMode = !isPwdLoginMode;
      isShowPwd = isPwdLoginMode;
      // 清空密码输入框已经输入的内容
      pwdEditController.clear();
    });
  }

  /// 切换密码显示隐藏
  void _changeShowPwd() {
    setState(() {
      isShowPwd = !isShowPwd;
    });
  }

  TextEditingController phoneEditController;
  TextEditingController pwdEditController;

  Timer timer;

  void startCounterDown() {
    isCounting = true;
    setState(() {
      // 不可点击验证码按钮
      qrCodeBtnEnable = false;
      qrCodeBtnText = '${currentDownNum}s重新获取';
    });
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      currentDownNum--;
      if (currentDownNum <= 0) {
        clearCounterDown();
      } else {
        isCounting = true;
        setState(() {
          // 不可点击验证码按钮
          qrCodeBtnEnable = false;
          qrCodeBtnText = '${currentDownNum}s重新获取';
        });
      }
    });
  }

  void clearCounterDown() {
    if (timer != null && timer.isActive) {
      timer.cancel();
      // 重置倒计时数
      currentDownNum = COUNT_DOWN;
      isCounting = false;
      setState(() {
        qrCodeBtnEnable = true;
        qrCodeBtnText = '获取验证码';
      });
    }
  }

  // 获取验证码方法
  Future<void> getAuthCode() async {
    // 获取输入的手机号码
    final phone = phoneEditController.text;
    RequestApi.sendAuthCode(phone).then((res) {
      if (res.result) {
        // 发送成功
        Fluttertoast.showToast(msg: "发送成功", textColor: Colors.white, backgroundColor: Colors.green);
        // 启动倒计时
        startCounterDown();
      }
    }).catchError((error) {
      print(error.toString());
      Fluttertoast.showToast(msg: "发送失败", textColor: Colors.white, backgroundColor: Colors.red);
    });
  }

  // 登录方法
  Future<void> login() async {
    // TODO 这里执行登录逻辑
    Future<LoginResultBean> loginResultBean;
    if (isPwdLoginMode) {
      loginResultBean = RequestApi.pwdLogin(phone, authCode);
    } else {
      loginResultBean = RequestApi.smsLogin(phone, authCode);
    }
    loginResultBean.then((res) {
      BaseUserStore userStore = ScopedModel.of(context);
      // 修改全局变量
      userStore.isLogin = true;
      userStore.userBean = res.user;

      // 存储到本地
      PrefsUtil.saveToken(res.token);
      PrefsUtil.saveUserBean(res.user);

      // 当前页出栈
      Navigator.of(context, rootNavigator: true).pop();
    }).catchError((error) {
      print(error.toString());
      Fluttertoast.showToast(msg: "登录失败", textColor: Colors.white, backgroundColor: Colors.red);
    });
  }

  @override
  void initState() {
    super.initState();
    phoneEditController = TextEditingController();
    phoneEditController.text = '';
    pwdEditController = TextEditingController();
    pwdEditController.text = '';
  }

  @override
  void dispose() {
    if (timer != null && timer.isActive) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    MediaQueryData mediaQueryData = MediaQuery.of(context);
//    print(mediaQueryData.padding.left);
//    print(mediaQueryData.padding.top);
//    print(mediaQueryData.padding.right);
//    print(mediaQueryData.padding.bottom);
//    print(mediaQueryData.devicePixelRatio);
//    print(mediaQueryData.size.width);
//    print(mediaQueryData.size.height);
    // 手机号输入行
    var phoneInputWidget = <Widget>[
      Expanded(
        child: TextField(
          controller: phoneEditController,
          keyboardType: TextInputType.phone,
          maxLength: 11,
          autofocus: false,
          decoration: InputDecoration(
            // 主要目的是隐藏Counter
            counter: Container(),
              icon: Image.asset('images/login_user.png', width: 26),
              hintText: '请输入手机号',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 10, bottom: 10),
            ),
          style: TextStyle(fontSize: 16),
          onChanged: (value) {
            phone = value;
            if (isPhoneValid(phone)) {
              if (!isCounting) {
                setState(() {
                  qrCodeBtnEnable = true;
                });
              }

              if (isAuthCodeValid(authCode)) {
                setState(() {
                  isEnableLogin = true;
                });
              }
            } else {
              setState(() {
                isEnableLogin = false;
                qrCodeBtnEnable = false;
              });
            }
          },
          ),
        )
    ];

    // 如果是短信登录  则显示获取验证码按钮
    if (!isPwdLoginMode) {
      phoneInputWidget.add(
        StateButtonWidget(
          isEnable: qrCodeBtnEnable,
          stateEnabled: BoxDecoration(
            border: Border.all(color: Color(0xFF606060)),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          statePressed: BoxDecoration(
            border: Border.all(color: Color(0xFF606060)),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0x30909090),
            ),
          stateDisable: BoxDecoration(
            border: Border.all(color: Color(0xFFD0D0D0)),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          onTap: () {
            getAuthCode();
          },
          child: Container(
            height: 26,
            width: 100,
            child: Center(
              child: Text(qrCodeBtnText, style: TextStyle(fontSize: 12, color: Color(qrCodeBtnEnable ? 0xFF606060 : 0xFFD0D0D0))),
              ),
            ),
          ),
        );
    }

    // 密码输入行
    var pwdInputWidget = <Widget>[
      Expanded(
        child: TextField(
          controller: pwdEditController,
          keyboardType: isPwdLoginMode ? TextInputType.text : TextInputType.number,
          maxLength: isPwdLoginMode ? 20 : 6,
          autofocus: false,
          obscureText: isShowPwd,
          decoration: InputDecoration(
            // 主要目的是隐藏Counter
            counter: Container(),
              icon: Image.asset(isPwdLoginMode ? 'images/login_password.png' : 'images/login_auth_code.png', width: 26),
              hintText: isPwdLoginMode ? '请输入8-20位密码' : '请输入6位验证码',
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 10, bottom: 10),
            ),
          style: TextStyle(fontSize: 16),
          onChanged: (value) {
            authCode = value;
            // 验证码有效
            if (isAuthCodeValid(authCode)) {
              // 密码有效
              if (isPhoneValid(phone)) {
                setState(() {
                  isEnableLogin = true;
                });
              }
            } else {
              setState(() {
                isEnableLogin = false;
              });
            }
          },
          ),
        ),
    ];

    // 如果是密码登录  就显示密码查看按钮
    if (isPwdLoginMode) {
      pwdInputWidget.add(GestureDetector(
        onTap: _changeShowPwd,
        child: Container(height: 30, width: 30, child: Image.asset(isShowPwd ? 'images/mimabukejian.png' : 'images/mimakejian.png', width: 30)),
        ));
    }

    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('登录', style: TextStyle(fontSize: 16, color: Colors.white)),
        elevation: 0,
        centerTitle: true,
        ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30),
            ),
          // logo
          Center(
            child: Image.asset('images/login_logo.png', width: 180),
            ),
          Padding(
            padding: EdgeInsets.only(top: 30),
            ),
          // 第一行手机号码输入布局
          Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Row(children: phoneInputWidget),
            ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            ),
          // 第二行验证码输入
          Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Row(children: pwdInputWidget),
            ),
          // 切换登录模式
//          Row(
//            mainAxisAlignment: MainAxisAlignment.end,
//            children: <Widget>[
//              FlatButton(
//                color: Colors.transparent,
//                highlightColor: Colors.transparent,
//                // 点击按钮的时候切换
//                onPressed: _changeLoginMode,
//                child: Text(isPwdLoginMode ? '使用短信登录' : '使用密码登录'),
//              ),
//              Padding(
//                padding: EdgeInsets.only(right: 20),
//              ),
//            ],
//          ),
          Padding(
            padding: EdgeInsets.only(top: 50),
            ),
          Center(
            child: StateButtonWidget(
              child: Container(
                width: 320,
                height: 40,
                child: Center(
                  child: Text(
                    '登录',
                    style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              isEnable: isEnableLogin,
              onTap: login,
              stateEnabled: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                gradient: LinearGradient(colors: <Color>[Color(0xFF05A8F1), Color(0xFF25EAA6)]),
                ),
              stateDisable: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                gradient: LinearGradient(colors: <Color>[Color(0xFF666666), Color(0xFFBBBBBB)]),
                ),
              statePressed: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                gradient: LinearGradient(colors: <Color>[Color(0xFF0558F1), Color(0xFF00D080)]),
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(),
                ),
              Text(
                '使用即表示同意',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF606060),
                  ),
                ),
              StateButtonWidget(
                child: Text(
                  '《用户协议》',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF2181D2),
                    ),
                  ),
                onTap: () {
                  WebViewPage.start(context, '用户协议', 'https://api.yishi-ai.com/static/html/license.html').then((res) {
                    print(res);
                  });
                },
                ),
              Expanded(
                child: Container(),
                ),
            ],
            )
        ],
        ),
      );
  }
}
