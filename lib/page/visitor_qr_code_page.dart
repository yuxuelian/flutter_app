import 'package:flutter/material.dart';
import 'package:scan_access/main.dart';

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
      ),
      body: Center(child: Text('访客二维码显示页')),
    );
  }
}
