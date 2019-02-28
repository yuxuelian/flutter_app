import 'package:flutter/material.dart';
import 'custom_alert_dialog.dart';
import 'state_button.dart';

class MessageDialogWidget extends StatelessWidget {
  final String message;
  final String leftBtnText;
  final String rightBtnText;

  MessageDialogWidget({
    Key key,
    this.message,
    this.leftBtnText,
    this.rightBtnText,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialogWidget(
      content: Container(
        width: 260,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 100,
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFD0D0D0)))),
              child: Center(child: Text(message)),
            ),
            Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: StateButtonWidget(
                      child: Center(child: Text(leftBtnText)),
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pop(false);
                      },
                    ),
                  ),

                  Container(
                    width: 1,
                    color: Color(0xFFD0D0D0),
                    child: Column(),
                  ),
                  Expanded(
                    child: StateButtonWidget(
                        child: Center(child: Text(rightBtnText, style: TextStyle(color: Color(0xFFEB891A)))),
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pop(true);
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
