import 'package:flutter/material.dart';
import 'pre_work_form.dart';
import 'activity_form.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';



class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int ongoingJobCount = 0;
  int activityFormCount = 0;
  List<OngoingJob> ongoingJobs = [];
  List<ActivityFormData> activityForms = [];

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  Future<void> refreshData() async {
    await loadOngoingJobs();
    await loadActivityForms();
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

        ongoingJobs = formDataList.where((formData) {
          // You can add a condition to check if this is an ongoing job
          // For example, if formData['status'] == 'ongoing'
          return true;
        }).map((formData) {
          final poReference = formData['poReference'];
          return OngoingJob(
            poReference: poReference,
            formData: formData,
          );
        }).toList();

        setState(() {
          ongoingJobCount = ongoingJobs.length;
        });
      }
    } catch (e) {
      print('Error loading ongoing jobs: $e');
    }
  }

  // Function to load activity form data from activity_form_data.json file
  Future<void> loadActivityForms() async {
    try {
      final directory = await getExternalStorageDirectory();
      if (directory == null) {
        return; // Handle error, unable to access storage directory
      }

      final filePath = '${directory.path}/activity_form_data.json';
      final file = File(filePath);

      if (await file.exists()) {
        final jsonData = await file.readAsString();
        final List<dynamic> formDataList = json.decode(jsonData);

        activityForms = formDataList.map((formData) {
          final poReference = formData['poReference'];
          return ActivityFormData(
            poReference: poReference,
            formData: formData,
          );
        }).toList();

        setState(() {
          activityFormCount = activityForms.length;
        });
      }
    } catch (e) {
      print('Error loading activity forms: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JCR Dashboard'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.account_circle),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.account_circle), // Add profile icon
                    title: Text('YourUserID'),
                  ),
                  enabled: false, // Disable user ID item
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.logout), // Add icon to the left of Logout
                    title: Text('Logout'),
                  ),
                  value: 'logout',
                ),
              ];
            },
            onSelected: (value) {
              if (value == 'logout') {
                // Navigate to the login page
                Navigator.pushReplacementNamed(context, '/');
              }
            },
          ),
        ],
      ),      body: RefreshIndicator(
        onRefresh: refreshData,
        child: Column(
          children: [
            // Ongoing Jobs Card
            CardWithCount(
              title: 'Ongoing Jobs',
              count: ongoingJobCount,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OngoingJobsPage(ongoingJobs: ongoingJobs),
                  ),
                );
              },
            ),
            // Pre-existing Forms Card
            CardWithCount(
              title: 'Pre-existing Forms',
              count: activityFormCount,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActivityFormsPage(activityForms: activityForms),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PreWorkFormPage(),
            ),
          );
        },
        child: Text('Start a Prework Form'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class CardWithCount extends StatelessWidget {
  final String title;
  final int count;
  final VoidCallback onPressed;

  CardWithCount({required this.title, required this.count, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.all(16.0),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(title),
              subtitle: Text('($count)'),
            ),
          ],
        ),
      ),
    );
  }
}

class OngoingJobsPage extends StatelessWidget {
  final List<OngoingJob> ongoingJobs;

  OngoingJobsPage({required this.ongoingJobs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ongoing Jobs'),
      ),
      body: ListView.builder(
        itemCount: ongoingJobs.length,
        itemBuilder: (context, index) {
          final job = ongoingJobs[index];
          final poReference = job.poReference;

          return ListTile(
            title: Text('$poReference (Ongoing)'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ActivityFormPage(poReference: poReference)
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// class JobDetailsPage extends StatelessWidget {
//   final OngoingJob job;
//
//   JobDetailsPage({required this.job});
//
//   @override
//   Widget build(BuildContext context) {
//     // Build your job details page using the provided 'job' data
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Job Details'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('PO Reference: ${job.poReference}'),
//             // You can display and edit other job details here
//           ],
//         ),
//       ),
//     );
//   }
// }

class OngoingJob {
  final String poReference;
  final Map<String, dynamic> formData;

  OngoingJob({
    required this.poReference,
    required this.formData,
  });
}

class ActivityFormsPage extends StatelessWidget {
  final List<ActivityFormData> activityForms;

  ActivityFormsPage({required this.activityForms});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity Forms'),
      ),
      body: ListView.builder(
        itemCount: activityForms.length,
        itemBuilder: (context, index) {
          final formData = activityForms[index];
          final poReference = formData.poReference;

          return ListTile(
            title: Text('$poReference (Activity Form)'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ActivityFormPage(poReference: poReference)
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ActivityFormData {
  final String poReference;
  final Map<String, dynamic> formData;

  ActivityFormData({
    required this.poReference,
    required this.formData,
  });
}
//
// class ActivityFormEditPage extends StatelessWidget {
//   final ActivityFormData formData;
//
//   ActivityFormEditPage({required this.formData});
//
//   @override
//   Widget build(BuildContext context) {
//     // Build your activity form edit page using the 'formData' data
//     // You can access formData.poReference and formData.formData to display and edit details
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Activity Form'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('PO Reference: ${formData.poReference}'),
//             // You can display and edit other activity form details here
//           ],
//         ),
//       ),
//     );
//   }
// }
