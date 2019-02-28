import 'package:flutter/material.dart';
import 'package:scan_access/http/request_method.dart';
import 'package:scan_access/main.dart';
import 'package:scan_access/store/user_store.dart';
import 'package:scan_access/widget/state_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scoped_model/scoped_model.dart';

import 'web_view_page.dart';

/// 未登录显示的页面
class LoginPage extends StatefulWidget {
  /// 跳转到登录页面
  static Future<T> toLoginPage<T extends Object>(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          // 要跳转的页面
          return LoginPage();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // 返回一个动画
          return MyApp.createTransition(animation, child);
        },
        transitionDuration: Duration(milliseconds: 400),
      ),
    );
  }

  const LoginPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  /// true 密码登录   false 验证码登录
  var isPwdLoginMode = false;

  /// true显示密码    false  不显示密码
  var isShowPwd = false;

  /// 标记是否能够点击登录按钮
  var isEnableLogin = true;

  /// 获取验证码按钮显示的文本内容(默认为   获取验证码)
  var qrCodeBtnText = '获取验证码';

  /// 获取验证码按钮是否可用(默认  可用)
  var qrCodeBtnEnable = true;

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

  @override
  void initState() {
    super.initState();
    phoneEditController = TextEditingController();
    phoneEditController.text = '15682070710';
    pwdEditController = TextEditingController();
    pwdEditController.text = '123456';
  }

  @override
  Widget build(BuildContext context) {
    // 手机号输入行
    var phoneInputWidget = <Widget>[
      Expanded(
        child: TextFormField(
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
          onTap: () async {
            // 获取输入的手机号码
            final phone = phoneEditController.text;
            // 调用发送验证码的接口
            final boolResultBean = await RequestApi.sendAuthCode(phone);
            if (boolResultBean.result) {
              // 发送成功
              Fluttertoast.showToast(msg: "发送成功", backgroundColor: Colors.green);
            }
          },
          child: Container(
            height: 26,
            width: 100,
            child: Center(
              child: Text(qrCodeBtnText, style: TextStyle(fontSize: 12, color: Color(0xFF606060))),
            ),
          ),
        ),
      );
    }

    // 密码输入行
    var pwdInputWidget = <Widget>[
      Expanded(
        child: TextFormField(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                // 点击按钮的时候切换
                onPressed: _changeLoginMode,
                child: Text(isPwdLoginMode ? '使用短信登录' : '使用密码登录'),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          ScopedModelDescendant<BaseUserStore>(
            builder: (context, child, model) => Center(
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
                    onTap: () {
                      // TODO 这里执行登录逻辑
                      // TODO 模拟登录成功 修改全局变量
                      model.setLogin(true);
                      // 当前页出栈
                      Navigator.of(context, rootNavigator: true).pop();
                    },
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
                  WebViewPage.toWebViewPage(context, '用户协议', 'https://api.yishi-ai.com/static/html/license.html').then((res) {
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
