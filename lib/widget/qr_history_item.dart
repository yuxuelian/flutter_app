import 'package:flutter/material.dart';

import '../page/visitor_qr_code_page.dart';

class QrHistoryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.white,
      splashColor: Colors.transparent,
      highlightColor: Color(0xFFD0D0D0),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.all(0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(border: Border(top: BorderSide(color: Color(0xFF2196F3)))),
        child: Row(
          children: <Widget>[
            Container(
              width: 50,
              child: Column(
                children: <Widget>[
                  Container(
                    width: 1,
                    height: 20,
                    color: Color(0xFF2196F3),
                  ),
                  Container(
                    width: 14,
                    height: 14,
                    decoration: ShapeDecoration(shape: CircleBorder(side: BorderSide(color: Color(0xFF2196F3), width: 1))),
                  ),
                  Expanded(
                    child: Container(
                      width: 1,
                      height: double.infinity,
                      color: Color(0xFF2196F3),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '成都市->汇锦广场->1栋1单元1001室',
                    maxLines: 1,
                    style: TextStyle(fontSize: 16, color: Color(0xFF606060)),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '姓名',
                          maxLines: 1,
                          style: TextStyle(fontSize: 16, color: Color(0xFF606060)),
                        ),
                      ),
                      Image.asset('assets/icon_blue_indicator.png', width: 20),
                      Text(
                        '2018-10-10 15:15:15',
                        maxLines: 1,
                        style: TextStyle(fontSize: 16, color: Color(0xFF606060)),
                      ),
                      Padding(padding: EdgeInsets.only(right: 20)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '姓名',
                          maxLines: 1,
                          style: TextStyle(fontSize: 16, color: Color(0xFF606060)),
                        ),
                      ),
                      Image.asset('assets/icon_orange_indicator.png', width: 20),
                      Text(
                        '2018-10-10 15:15:15',
                        maxLines: 1,
                        style: TextStyle(fontSize: 16, color: Color(0xFF606060)),
                      ),
                      Padding(padding: EdgeInsets.only(right: 20)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onPressed: () {
        VisitorQrCodePage.start(context);
      },
    );
  }
}
