import 'package:flutter/material.dart';

class TemplatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TemplateState();
}

class TemplateState extends State<TemplatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('模板页', style: TextStyle(fontSize: 16, color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Text('模板页'),
      ),
    );
  }
}
