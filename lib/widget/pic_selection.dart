import 'package:flutter/material.dart';

class PicSelection extends StatelessWidget {
  /// 0 拍照  1  相册  -1 取消

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FlatButton(
            color: Colors.white,
            splashColor: Colors.transparent,
            highlightColor: Color(0xFFD0D0D0),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7),
              topRight: Radius.circular(7),
            )),
            onPressed: () {
              Navigator.of(context).pop(0);
            },
            child: Container(
              height: 40,
              width: double.infinity,
              child: Center(
                child: Text('拍照', style: TextStyle(fontSize: 16, color: Color(0xFFEB891A))),
              ),
            ),
          ),
          Container(height: 1, color: Color(0xFF909090)),
          FlatButton(
            color: Colors.white,
            splashColor: Colors.transparent,
            highlightColor: Color(0xFFD0D0D0),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(7),
              bottomRight: Radius.circular(7),
            )),
            onPressed: () {
              Navigator.of(context).pop(1);
            },
            child: Container(
              height: 40,
              width: double.infinity,
              child: Center(
                child: Text('相册', style: TextStyle(fontSize: 16, color: Color(0xFFEB891A))),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          FlatButton(
            color: Colors.white,
            splashColor: Colors.transparent,
            highlightColor: Color(0xFFD0D0D0),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7))),
            onPressed: () {
              Navigator.of(context).pop(-1);
            },
            child: Container(
              height: 40,
              width: double.infinity,
              child: Center(
                child: Text('取消', style: TextStyle(fontSize: 16, color: Color(0xFF909090))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
