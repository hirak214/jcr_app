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
  String username = '';
  int ongoingJobCount = 0;
  int activityFormCount = 0;
  int waitingApprovalCount = 0; // New count variable
  int completedJobsCount = 0; // New count variable
  List<OngoingJob> ongoingJobs = [];
  List<ActivityFormData> activityForms = [];
  List<WaitingApprovalData> waitingApprovalList = []; // New list for waiting approval
  List<CompletedJobData> completedJobsList = []; // New list for completed jobs

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Receive the username argument passed from LoginPage
    final routeArgs = ModalRoute.of(context)?.settings.arguments;
    if (routeArgs != null && routeArgs is String) {
      username = routeArgs;
    }
  }

  Future<void> refreshData() async {
    await loadOngoingJobs();
    await loadActivityForms();
    await loadWaitingApproval(); // Load waiting approval data
    await loadCompletedJobs(); // Load completed jobs data
  }

  Future<void> loadWaitingApproval() async {
    // Implement loading "Waiting Approval" data here
    // This is similar to the loadOngoingJobs and loadActivityForms methods
  }

  Future<void> loadCompletedJobs() async {
    // Implement loading "Completed Jobs" data here
    // This is similar to the loadOngoingJobs and loadActivityForms methods
  }

  // Function to load ongoing job data from form_data.json file
  Future<void> loadOngoingJobs() async {
    try {
      final directory = await getExternalStorageDirectory();
      if (directory == null) {
        return; // Handle error, unable to access the storage directory
      }

      final filePath = '${directory.path}/form_data.json';
      final file = File(filePath);

      if (await file.exists()) {
        final jsonData = await file.readAsString();
        final List<dynamic> formDataList = json.decode(jsonData);

        ongoingJobs = formDataList.where((formData) {
            // Check if 'activity_started_flag' is false before adding
            if (formData['activity_started_flag'] == false) {
              final poReference = formData['poReference'];
              return true;
            }

          return false;
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

        activityForms = formDataList.where((formData) {
          // Check if 'activity_status' is "ongoing"
          return formData['activity_status'] == 'ongoing';
        }).map((formData) {
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
                    leading: Icon(Icons.account_circle),
                    title: Text(username),
                  ),
                  enabled: false,
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                  ),
                  value: 'logout',
                ),
              ];
            },
            onSelected: (value) {
              if (value == 'logout') {
                Navigator.pushReplacementNamed(context, '/');
              }
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: Column(
          children: [
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
            CardWithCount(
              title: 'Pending Activity Forms',
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
            CardWithCount(
              title: 'Waiting Approval', // New card title
              count: waitingApprovalCount, // Use the count variable
              onPressed: () {
                // Implement navigation to the "Waiting Approval" page
              },
            ),
            CardWithCount(
              title: 'Completed Jobs', // New card title
              count: completedJobsCount, // Use the count variable
              onPressed: () {
                // Implement navigation to the "Completed Jobs" page
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
        child: Text('Start a Pre-Work Form'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class CompletedJobData {
}

class WaitingApprovalData {
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
          final formData = job.formData;

          return OngoingJobTile(
            poReference: poReference,
            customerName: formData['customerName'],
            location: formData['location'],
            jcrReference: formData['jcrRefNo'],
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ActivityFormPage(poReference: poReference),
                ),
              );
            },
          );
        },
      ),
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

class OngoingJobTile extends StatefulWidget {
  final String poReference;
  final String customerName;
  final String location;
  final String jcrReference;
  final VoidCallback onPressed;

  OngoingJobTile({
    required this.poReference,
    required this.customerName,
    required this.location,
    required this.jcrReference,
    required this.onPressed,
  });

  @override
  _OngoingJobTileState createState() => _OngoingJobTileState();
}

class _OngoingJobTileState extends State<OngoingJobTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.all(16.0),
      child: ExpansionTile(
        title: Text(widget.poReference),
        children: [
          ListTile(
            title: Row(
              children: [
                Text('Customer Name: ${widget.customerName}'),
                SizedBox(width: 16),
                Text('Location: ${widget.location}'),
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Text('JCR Ref No: ${widget.jcrReference}'),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: widget.onPressed,
                  child: Text('Start Activity Form'),
                ),
              ],
            ),
          ),
        ],
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        initiallyExpanded: _isExpanded,
      ),
    );
  }
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
