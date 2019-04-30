import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../bean/index.dart';
import '../main.dart';
import '../widget/logo2.dart';
import '../utils/prefs_util.dart';

class VisitorQrCodePage extends StatefulWidget {
  static Future<T> start<T extends Object>(BuildContext context, QrCodeBean qrCodeBean) {
    return Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => VisitorQrCodePage(qrCodeBean),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => MyApp.createTransition(animation, child),
        transitionDuration: Duration(milliseconds: 400),
      ),
    );
  }

  final QrCodeBean qrCodeBean;

  VisitorQrCodePage(this.qrCodeBean, {Key key}) : super(key: key);

  _VisitorQrCodePageState createState() => _VisitorQrCodePageState();
}

class _VisitorQrCodePageState extends State<VisitorQrCodePage> {
  GlobalKey<_VisitorQrCodePageState> _repaintBoundaryKey = GlobalKey();

  Future<Uint8List> _capturePng() async {
    try {
      RenderRepaintBoundary boundary = _repaintBoundaryKey.currentContext.findRenderObject();
      final image = await boundary.toImage();
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      return byteData.buffer.asUint8List();
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> showImageDialog(BuildContext context) async {
    final imageBytes = await _capturePng();
//    String base64encode = base64Encode(imageBytes);
    return await showDialog<void>(
        context: context,
        builder: (context) {
          return Container(
            width: 330,
            height: 462,
            child: Image.memory(imageBytes, width: 330),
          );
        });
  }

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
            onTap: () {
              showImageDialog(context);
            },
          )
        ],
      ),
      body: Center(
        child: RepaintBoundary(
          key: _repaintBoundaryKey,
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
                    data: widget.qrCodeBean.qr_code,
                    onError: (ex) {
                      print('[QR] ERROR - $ex');
                    },
                    version: 2,
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Text(
                    '到访地址: ${widget.qrCodeBean.fullHouseName}',
                    style: TextStyle(fontSize: 14, color: Color(0xFF606060)),
                  ),
                  Text(
                    '过期时间: ${widget.qrCodeBean.expire}',
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
      ),
    );
  }
}
