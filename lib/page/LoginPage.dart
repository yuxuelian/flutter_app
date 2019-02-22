import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/store/UserStore.dart';
import 'package:flutter_app/widget/StateButtonWidget.dart';
import 'package:scoped_model/scoped_model.dart';

import 'WebViewPage.dart';

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
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  /// true 密码登录   false 验证码登录
  var isPwdLoginMode = false;

  /// true显示密码    false  不显示密码
  var isShowPwd = false;

  /// 标记是否能够点击登录按钮
  var isEnableLogin = false;

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

  TextEditingController pwdEditController;

  @override
  void initState() {
    super.initState();
    pwdEditController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    print("LoginPage  build");
    // 手机号输入行
    var phoneInputWidget = <Widget>[
      Expanded(
        flex: 1,
        child: TextFormField(
          initialValue: "15682070710",
          keyboardType: TextInputType.phone,
          maxLength: 11,
          decoration: InputDecoration(
            // 主要目的是隐藏Counter
            counter: Container(),
            icon: Image.asset(
              "images/login_user.png",
              width: 26,
            ),
            hintText: "请输入手机号",
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 6, bottom: 6),
          ),
          style: TextStyle(fontSize: 16),
        ),
      )
    ];

    // 如果是短信登录  则显示获取验证码按钮
    if (!isPwdLoginMode) {
      phoneInputWidget.add(GestureDetector(
        onTap: () {
          // TODO 点击获取验证码按钮
          setState(() {
            // 交换状态
            isEnableLogin = !isEnableLogin;
          });
        },
        child: Container(
          height: 26,
          width: 100,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Center(
            child: Text("获取验证码", style: TextStyle(fontSize: 12, color: Colors.black)),
          ),
        ),
      ));
    }

    // 密码输入行
    var pwdInputWidget = <Widget>[
      Expanded(
        flex: 1,
        child: TextFormField(
          controller: pwdEditController,
          keyboardType: isPwdLoginMode ? TextInputType.text : TextInputType.number,
          maxLength: isPwdLoginMode ? 20 : 6,
          obscureText: isShowPwd,
          decoration: InputDecoration(
            // 主要目的是隐藏Counter
            counter: Container(),
            icon: Image.asset(
              isPwdLoginMode ? "images/login_password.png" : "images/login_auth_code.png",
              width: 26,
            ),
            hintText: isPwdLoginMode ? "请输入8-20位密码" : "请输入6位验证码",
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 6, bottom: 6),
          ),
          style: TextStyle(fontSize: 16),
        ),
      ),
    ];

    // 如果是密码登录  就显示密码查看按钮
    if (isPwdLoginMode) {
      pwdInputWidget.add(GestureDetector(
        onTap: _changeShowPwd,
        child: Container(
            height: 30,
            width: 30,
            child: Image.asset(
              isShowPwd ? "images/mimabukejian.png" : "images/mimakejian.png",
              width: 30,
            )),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
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
            child: Image.asset(
              "images/login_logo.png",
              width: 180,
            ),
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
                child: Text(isPwdLoginMode ? "使用短信登录" : "使用密码登录"),
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
                          "登录",
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
                    stateEnabled: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(7)), gradient: LinearGradient(colors: <Color>[Color(0xFF05A8F1), Color(0xFF25EAA6)])),
                    stateDisable: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(7)), gradient: LinearGradient(colors: <Color>[Color(0xFF666666), Color(0xFFBBBBBB)])),
                    statePressed: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(7)), gradient: LinearGradient(colors: <Color>[Color(0xFF0558F1), Color(0xFF00D080)])),
                  ),
                ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Text(
                "使用即表示同意",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF606060),
                ),
              ),
              StateButtonWidget(
                child: Text(
                  "《用户协议》",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF2181D2),
                  ),
                ),
                stateEnabled: BoxDecoration(color: Colors.transparent),
                onTap: () {
                  WebViewPage.toWebViewPage(context, "用户协议", "https://www.baidu.com").then((res) {
                    print(res);
                  });
                },
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
