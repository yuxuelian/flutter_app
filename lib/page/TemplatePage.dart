import 'package:flutter/material.dart';

class TemplatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TemplateState();
  }
}

class TemplateState extends State<TemplatePage> {
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
