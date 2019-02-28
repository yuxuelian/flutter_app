import 'package:flutter/material.dart';
import 'package:scan_access/widget/logo.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr/qr.dart';

class EnableCardWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EnableCardState();
}

class EnableCardState extends State<EnableCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF222222),
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
            color: Color(0xFFEBEBEB),
            elevation: 0,
            child: Column(
              children: <Widget>[
                LogoWidget(),
                Expanded(
                  child: Container(),
                ),
                QrImage(
                  data: '12345678123456781234567812345678',
                  onError: (ex) {
                    print('[QR] ERROR - $ex');
                  },
                  version: 2,
                ),
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
