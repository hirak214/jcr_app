import 'package:flutter/material.dart';
import 'pre_work_form.dart';
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
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Start a New Job'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreWorkFormPage(),
                ),
              );
            },
          ),
          ExpansionTile(
            title: Text('Previous Jobs'),
            children: [
              ListTile(
                title: Text('Job 1'),
                onTap: () {
                  // Navigate to details of Job 1
                },
              ),
              ListTile(
                title: Text('Job 2'),
                onTap: () {
                  // Navigate to details of Job 2
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
