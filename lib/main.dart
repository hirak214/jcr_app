import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'login_page.dart';
import 'activity_form.dart';


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
      initialRoute: '/', // Define the initial route
      routes: {
        '/': (context) => LoginPage(), // Map the root route to the LoginPage
        '/dashboard': (context) => Dashboard(),
      },
    );
  }
}
