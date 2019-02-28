import 'package:flutter/material.dart';

class CustomDialogWidget extends AlertDialog {
  CustomDialogWidget({
    Key key,
    Widget title,
    EdgeInsetsGeometry titlePadding,
    TextStyle titleTextStyle,
    Widget content,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.all(0),
    TextStyle contentTextStyle,
    List<Widget> actions,
    Color backgroundColor = Colors.white,
    double elevation = 0,
    String semanticLabel,
    ShapeBorder shape = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
  }) : super(
          key: key,
          title: title,
          titlePadding: titlePadding,
          titleTextStyle: titleTextStyle,
          content: content,
          contentPadding: contentPadding,
          contentTextStyle: contentTextStyle,
          actions: actions,
          backgroundColor: backgroundColor,
          elevation: elevation,
          semanticLabel: semanticLabel,
          shape: shape,
        );
}
