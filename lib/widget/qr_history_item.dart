import 'package:flutter/material.dart';

import '../page/visitor_qr_code_page.dart';
import '../bean/index.dart';

class QrHistoryItem extends StatelessWidget {
  final QrCodeBean qrCodeBean;

  QrHistoryItem(this.qrCodeBean);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.white,
      splashColor: Colors.transparent,
      highlightColor: Color(0xFFD0D0D0),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.all(0),
      child: Container(
        height: 70,
        decoration: BoxDecoration(border: Border(top: BorderSide(color: Color(0xFF2196F3)))),
        child: Row(
          children: <Widget>[
            Container(
              width: 40,
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
                    qrCodeBean.fullHouseName,
                    maxLines: 1,
                    style: TextStyle(fontSize: 16, color: Color(0xFF606060)),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "姓名:${qrCodeBean.name.isEmpty ? '未填写' : qrCodeBean.name}",
                          maxLines: 1,
                          style: TextStyle(fontSize: 16, color: Color(0xFF606060)),
                        ),
                      ),
                      Image.asset('assets/icon_blue_indicator.png', width: 20),
                      Text(
                        qrCodeBean.created_at,
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
                          "手机号:${qrCodeBean.phone.isEmpty ? '未填写' : qrCodeBean.phone}",
                          maxLines: 1,
                          style: TextStyle(fontSize: 16, color: Color(0xFF606060)),
                        ),
                      ),
                      Image.asset('assets/icon_orange_indicator.png', width: 20),
                      Text(
                        qrCodeBean.expire,
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
        VisitorQrCodePage.start(context, qrCodeBean);
      },
    );
  }
}
