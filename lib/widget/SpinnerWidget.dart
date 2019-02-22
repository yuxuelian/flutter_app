import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class SpinnerWidget extends StatefulWidget {
  final String message;

  final Widget child;

  final Color messageColor;

  final Color smokeScreenColor;

  SpinnerWidget(this.child, this.message, {this.messageColor: const Color(0xFFFFFFFF), this.smokeScreenColor: const Color.fromRGBO(0, 0, 0, 0.7)});

  @override
  _State createState() => _State();
}

class _State extends State<SpinnerWidget> {
  @override
  Widget build(BuildContext context) {
    final stacks = <Widget>[Positioned.fill(child: widget.child)];
    if (widget.message is String) {
      stacks.add(
        Positioned.fill(
          child: Container(
              color: widget.smokeScreenColor,
              child: Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Container(margin: EdgeInsets.only(top: 20.0)),
                  Text(widget.message, style: TextStyle(color: widget.messageColor, fontSize: 16.0)),
                ],
              ))),
        ),
      );
    }
    return Stack(children: stacks);
  }
}
