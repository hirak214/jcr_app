import 'package:flutter/material.dart';
import 'pre_work_form.dart';
import 'activity_form.dart';
import 'dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JCR App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      // home: PreWorkFormPage(),
      home: Dashboard(),
    );
  }
}
