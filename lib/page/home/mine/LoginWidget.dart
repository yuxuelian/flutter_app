import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_app/store/UserStore.dart';

/// 未登录显示的页面
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginPage> {
  /// true 密码登录   false 验证码登录
  var loginMode = false;

  /// 是否显示密码  false  不显示密码   true显示密码
  var isShowPwd = false;

  /// 切换密码登录或者验证码登录
  void _changeLoginMode() {
    setState(() {
      loginMode = !loginMode;
      if (loginMode) {
        isShowPwd = true;
      } else {
        isShowPwd = false;
      }
    });
  }

  /// 切换密码显示隐藏
  void _changeShowPwd() {
    setState(() {
      isShowPwd = !isShowPwd;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 手机号收入行
    var phoneInputWidget = <Widget>[
      Expanded(
        flex: 1,
        child: TextFormField(
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
              icon: Image.asset(
                "images/login_user.png",
                width: 26,
              ),
              hintText: "请输入手机号",
              border: InputBorder.none),
          style: TextStyle(fontSize: 16),
        ),
      )
    ];

    // 如果是短信登录  则显示获取验证码按钮
    if (!loginMode) {
      phoneInputWidget.add(Container(
        height: 26,
        width: 100,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Center(
          child: Text("获取验证码",
              style: TextStyle(fontSize: 12, color: Colors.black)),
        ),
      ));
    }

    // 密码输入行
    var pwdInputWidget = <Widget>[
      Expanded(
          flex: 1,
          child: TextFormField(
            obscureText: isShowPwd,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                icon: Image.asset(
                  loginMode
                      ? "images/login_password.png"
                      : "images/login_auth_code.png",
                  width: 26,
                ),
                hintText: loginMode ? "请输入8-20位密码" : "请输入6位验证码",
                border: InputBorder.none),
            style: TextStyle(fontSize: 16),
          ))
    ];

    // 如果是密码登录  就显示密码查看按钮
    if (loginMode) {
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
        title: Text("登录", style: TextStyle(fontSize: 16)),
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
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.grey))),
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Flex(direction: Axis.horizontal, children: phoneInputWidget),
          ),
          // 第二行验证码输入
          Container(
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.grey))),
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Flex(direction: Axis.horizontal, children: pwdInputWidget),
          ),
          // 切换登录模式
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                // 点击按钮的时候切换
                onPressed: _changeLoginMode,
                child: Text(loginMode ? "使用短信登录" : "使用密码登录"),
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
            builder: (context, child, model) =>
                // 登录按钮
                Container(
                  padding: EdgeInsets.all(20),
                  child: GestureDetector(
                    onTap: () {
                      // 登录成功 修改全局变量
                      model.setLogin(true);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          gradient: LinearGradient(colors: <Color>[
                            Color(0xFF666666),
                            Color(0xFFBBBBBB)
                          ])),
                      height: 40,
                      child: Center(
                        child: Text(
                          "登录",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
