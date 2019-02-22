import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:flutter_app/page/HomePage.dart';
import 'store/UserStore.dart';

void main() => runApp(
      MyApp(
        userStore: UserStore(),
      ),
    );

class MyApp extends StatelessWidget {
  final BaseUserStore userStore;

  MyApp({Key key, @required this.userStore}) : super(key: key); // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ScopedModel<BaseUserStore>(
      model: userStore,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          platform: TargetPlatform.iOS,
          primarySwatch: MaterialColor(0xFF2181D2, <int, Color>{
            50: Color(0xFF2181D2),
            100: Color(0xFF2181D2),
            200: Color(0xFF2181D2),
            300: Color(0xFF2181D2),
            400: Color(0xFF2181D2),
            500: Color(0xFF2181D2),
            600: Color(0xFF2181D2),
            700: Color(0xFF2181D2),
            800: Color(0xFF2181D2),
            900: Color(0xFF2181D2),
          }),
        ),
        home: HomePage(),
      ),
    );
  }

  static SlideTransition createTransition(Animation<double> animation, Widget child) {
    return new SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child,
    );
  }
}
