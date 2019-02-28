import 'package:flutter/material.dart';
import 'state_button.dart';

class QrHistoryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StateButtonWidget(
      child: Container(
        height: 80,
        decoration: BoxDecoration(border: Border(top: BorderSide(color: Color(0xFF606060)))),
      ),
    );
  }
}
