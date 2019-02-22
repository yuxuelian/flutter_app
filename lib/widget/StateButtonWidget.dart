import 'package:flutter/material.dart';

class StateButtonWidget extends StatelessWidget {
  final Widget child;

  final bool isEnable;

  final Decoration stateDisable;

  final GestureTapCallback onTap;

  final Decoration stateEnabled;

  final Decoration statePressed;

  StateButtonWidget({this.child, this.onTap, this.isEnable: true, @required this.stateEnabled, Decoration stateDisable, Decoration statePressed})
      : assert(stateEnabled != null),
        stateDisable = stateDisable == null ? stateEnabled : stateDisable,
        statePressed = statePressed == null ? stateEnabled : statePressed;

  @override
  Widget build(BuildContext context) {
    return isEnable ? FlatButtonWidget(child: child, onTap: onTap, stateEnabled: stateEnabled, statePressed: statePressed) : Container(child: child, decoration: stateDisable);
  }
}

class FlatButtonWidget extends StatefulWidget {
  final Widget child;

  final GestureTapCallback onTap;

  final Decoration stateEnabled;

  final Decoration statePressed;

  FlatButtonWidget({this.child, this.onTap, this.stateEnabled, this.statePressed});

  @override
  State createState() => FlatButtonState(child: child, onTap: onTap, stateEnabled: stateEnabled, statePressed: statePressed);
}

class FlatButtonState extends State<FlatButtonWidget> {
  final Widget child;

  final GestureTapCallback onTap;

  final Decoration stateEnabled;

  final Decoration statePressed;

  Decoration currentDecoration;

  FlatButtonState({this.child, this.onTap, this.stateEnabled, this.statePressed});

  @override
  void initState() {
    super.initState();
    currentDecoration = stateEnabled;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          decoration: currentDecoration,
          child: child,
        ),
        onTap: onTap,
        onTapDown: (e) {
          setState(() {
            currentDecoration = statePressed;
          });
        },
        onTapUp: (e) {
          setState(() {
            currentDecoration = stateEnabled;
          });
        },
        onTapCancel: () {
          setState(() {
            currentDecoration = stateEnabled;
          });
        });
  }
}
