import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../store/user_store.dart';
import '../../totp/totp.dart';
import '../../widget/logo.dart';

class EnableCardWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EnableCardState();
}

class EnableCardState extends State<EnableCardWidget> {
  Timer _timer;
  int totpCode;

  @override
  void initState() {
    super.initState();
    // 初始化的时候获取一次
    this.totpCode = generateTOTPCode();
    // 每秒计算一次totp值
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        totpCode = generateTOTPCode();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF202020),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        title: Text('我的电子门禁卡', style: TextStyle(fontSize: 16)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Container(
          width: 330,
          height: 462,
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color(0xFFE0E0E0),
            elevation: 0,
            child: Column(
              children: <Widget>[
                LogoWidget(),
                Expanded(
                  child: Container(),
                ),
                ScopedModelDescendant(builder: (context, child, BaseUserStore userStore) {
                  return QrImage(
                    data: '${userStore.userBean?.key ?? '---'}$totpCode',
                    onError: (ex) {
                      print('[QR] ERROR - $ex');
                    },
                    version: 2,
                  );
                }),
                Expanded(
                  child: Container(),
                ),
                Text(
                  '门禁摄像头扫此动态二维码开门，人脸注册',
                  style: TextStyle(fontSize: 14, color: Color(0xFF606060)),
                ),
                Text(
                  '扫码距离15cm-60cm',
                  style: TextStyle(fontSize: 14, color: Color(0xFF606060)),
                ),
                Expanded(
                  child: Container(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
