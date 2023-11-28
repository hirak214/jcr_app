import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class OverviewPage extends StatefulWidget {
  final String poReference;

  OverviewPage({
    required this.poReference,
  });

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  List<dynamic> formData = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
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

        // Filter data for the specific PO reference
        final filteredData = formDataList
            .where((data) => data['poReference'] == widget.poReference)
            .toList();

        setState(() {
          formData = filteredData;
          print(formData);
        });
      }
    } catch (e) {
      print('Error loading JSON data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Overview for PO Reference: ${widget.poReference}'),
      ),
      body: formData.isEmpty
          ? Center(
        child: Text('No data available for this PO reference.'),
      )
          : Center(
        child: Text('${formData[0]}'),
      )
    );
  }
}
