import 'package:flutter/material.dart';
import 'package:jcr_app/jcr_form.dart';

void main() {
  runApp(JCRApp());
}

class JCRApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('JCR App'),
        ),
        body: JCRForm(),
      ),
    );
  }
}
