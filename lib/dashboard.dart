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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Job Statistics
          Container(
            padding: EdgeInsets.all(16.0),
            color:  Color(0xFF186F65),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStat('Ongoing', '5'), // Replace '5' with actual ongoing job count
                _buildStat('Completed', '10'), // Replace '10' with actual completed job count
                _buildStat('Pending', '3'), // Replace '3' with actual pending job count
              ],
            ),
          ),
          // Ongoing Jobs
          Expanded(
            child: ListView(
              children: [
                ExpansionTile(
                  title: Text('Ongoing Jobs'),
                  children: [
                    ListTile(
                      title: Text('Job 3 (Ongoing)'),
                      onTap: () {
                        // Navigate to details of Job 3 (Ongoing)
                      },
                    ),
                    ListTile(
                      title: Text('Job 4 (Ongoing)'),
                      onTap: () {
                        // Navigate to details of Job 4 (Ongoing)
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Completed Jobs
          Expanded(
            child: ListView(
              children: [
                ExpansionTile(
                  title: Text('Completed Jobs'),
                  children: [
                    ListTile(
                      title: Text('Job 1 (Completed)'),
                      onTap: () {
                        // Navigate to details of Job 1 (Completed)
                      },
                    ),
                    ListTile(
                      title: Text('Job 2 (Completed)'),
                      onTap: () {
                        // Navigate to details of Job 2 (Completed)
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Pending Jobs
          Expanded(
            child: ListView(
              children: [
                ExpansionTile(
                  title: Text('Pending Jobs'),
                  children: [
                    ListTile(
                      title: Text('Job 5 (Pending)'),
                      onTap: () {
                        // Navigate to details of Job 5 (Pending)
                      },
                    ),
                    ListTile(
                      title: Text('Job 6 (Pending)'),
                      onTap: () {
                        // Navigate to details of Job 6 (Pending)
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PreWorkFormPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ],
    );
  }
}
