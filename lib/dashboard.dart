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
// Ongoing Jobs (integrated widget)
          Expanded(
            child: OngoingJobsWidget(),
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

class OngoingJobsWidget extends StatefulWidget {
  @override
  _OngoingJobsWidgetState createState() => _OngoingJobsWidgetState();
}

class _OngoingJobsWidgetState extends State<OngoingJobsWidget> {
  List<OngoingJob> ongoingJobs = [];

  @override
  void initState() {
    super.initState();
    loadOngoingJobs();
  }

  Future<void> loadOngoingJobs() async {
    // Load ongoing job data from the form_data.json file
    // (Same code as provided in the previous response)
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Ongoing Jobs'),
      children: ongoingJobs.map((job) {
        final poReference = job.poReference;
        final formData = job.formData;

        return ListTile(
          title: Text('$poReference (Ongoing)'),
          onTap: () {
            // Navigate to details of the selected ongoing job
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
