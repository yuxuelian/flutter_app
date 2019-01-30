import 'package:flutter/material.dart';

class ScenePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SceneState();
  }
}

class SceneState extends State<ScenePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("模板页"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Text("模板页"),
      ),
    );
  }
}
