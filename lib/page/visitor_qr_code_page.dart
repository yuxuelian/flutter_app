import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../main.dart';
import '../widget/logo2.dart';

class VisitorQrCodePage extends StatefulWidget {
  static Future<T> start<T extends Object>(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => VisitorQrCodePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => MyApp.createTransition(animation, child),
        transitionDuration: Duration(milliseconds: 400),
      ),
    );
  }

  final Widget child;

  VisitorQrCodePage({Key key, this.child}) : super(key: key);

  _VisitorQrCodePageState createState() => _VisitorQrCodePageState();
}

class _VisitorQrCodePageState extends State<VisitorQrCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF202020),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('访客二维码', style: TextStyle(fontSize: 16, color: Colors.white)),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          InkWell(
            child: Container(
              alignment: Alignment.center,
              width: 56,
              child: Text('发送', style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
            onTap: () {},
          )
        ],
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
                Logo2Widget(),
                Expanded(
                  child: Container(),
                ),
                QrImage(
                  data: '123123',
                  onError: (ex) {
                    print('[QR] ERROR - $ex');
                  },
                  version: 2,
                ),
                Expanded(
                  child: Container(),
                ),
                Text(
                  '到访地址: 1栋->1单元->999号',
                  style: TextStyle(fontSize: 14, color: Color(0xFF606060)),
                ),
                Text(
                  '过期时间: 2019-03-26 10:57:39',
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
