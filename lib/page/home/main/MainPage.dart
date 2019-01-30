import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_app/store/UserStore.dart';

import 'DisableCardWidget.dart';
import 'EnableCardWidget.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<BaseUserStore>(
      builder: (context, child, model) =>
          model.isLogin ? EnableCardWidget() : DisableCardWidget(),
    );
  }
}
