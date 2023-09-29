import 'package:flutter/material.dart';
import 'pre_work_form.dart';
import 'activity_form.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

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

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<OngoingJob> ongoingJobs = [];

  @override
  void initState() {
    super.initState();
    loadOngoingJobs();
  }

  // Function to load ongoing job data from form_data.json file
  Future<void> loadOngoingJobs() async {
    try {
      final directory = await getExternalStorageDirectory();
      if (directory == null) {
        return; // Handle error, unable to access storage directory
      }

      final filePath = '${directory.path}/form_data.json';
      final file = File(filePath);

      if (await file.exists()) {
        final jsonData = await file.readAsString();
        final List<dynamic> formDataList = json.decode(jsonData);

        ongoingJobs = formDataList
            .where((formData) {
          // You can add a condition to check if this is an ongoing job
          // For example, if formData['status'] == 'ongoing'
          return true;
        })
            .map((formData) {
          final poReference = formData['poReference'];
          return OngoingJob(
            poReference: poReference,
            formData: formData,
          );
        })
            .toList();

        setState(() {});
      }
    } catch (e) {
      print('Error loading ongoing jobs: $e');
    }
  }

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
            color: Color(0xFF186F65),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStat('Ongoing', '${ongoingJobs.length}'),
                _buildStat('Completed', '10'), // Replace '10' with actual completed job count
                _buildStat('Pending', '3'), // Replace '3' with actual pending job count
              ],
            ),
          ),
          // Ongoing Jobs (integrated widget)
          Expanded(
            child: OngoingJobsWidget(ongoingJobs: ongoingJobs),
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

class OngoingJobsWidget extends StatelessWidget {
  final List<OngoingJob> ongoingJobs;

  OngoingJobsWidget({required this.ongoingJobs});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Ongoing Jobs'),
      children: ongoingJobs.map((job) {
        final poReference = job.poReference;

        return ListTile(
          title: Text('$poReference (Ongoing)'),
          onTap: () {
            // Navigate to ActivityFormPage without passing formData
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ActivityFormPage(),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class OngoingJob {
  final String poReference;
  final Map<String, dynamic> formData;

  OngoingJob({
    required this.poReference,
    required this.formData,
  });
}
