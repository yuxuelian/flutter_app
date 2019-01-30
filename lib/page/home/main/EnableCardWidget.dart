import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EnableCardWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EnableCardState();
  }
}

class EnableCardState extends State<EnableCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("已登录"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: QrImage(
                data: "123",
                size: 300.0,
                onError: (ex) {
                  print("[QR] ERROR - $ex");
                }),
          )
        ],
      ),
    );
  }
}
