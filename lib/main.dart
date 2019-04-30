import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:scan_access/page/home_page.dart';

import 'store/user_store.dart';

void main() {
  final providers = Providers();
  providers.provide(Provider<BaseUserStore>.value(userStore));
  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
}

class MyApp extends StatefulWidget {
  @override
  State createState() => _MyAppState();

  static SlideTransition createTransition(Animation<double> animation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child,
    );
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        platform: TargetPlatform.iOS,
        primarySwatch: Colors.blue,
        canvasColor: Colors.transparent,
      ),
      home: HomePage(),
    );
  }
}
