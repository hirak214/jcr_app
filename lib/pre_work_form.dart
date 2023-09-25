import 'package:flutter/material.dart';

class PreWorkFormPage extends StatefulWidget {
  @override
  _PreWorkFormPageState createState() => _PreWorkFormPageState();
}

class _PreWorkFormPageState extends State<PreWorkFormPage> {
  TextEditingController poReferenceController = TextEditingController();
  TextEditingController poDateController = TextEditingController();

  String jcrRefNo = 'HKSandeep';

  String customerName = '';
  String location = '';
  String department = '';
  String jobLocationAndId = '';
  String contactPerson = '';
  String mobileNumber = '';

  String defectType = 'Type-A';
  String defectDetails = '';
  String outputSheet = 'yes';
  int numberOfLayers = 0;
  String repairDimensions = '';
  String applicationType = 'on-line';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pre Work Form'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Installer Details
            Text(
              'Installer Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              readOnly: true,
              initialValue: 'S Bharmappa',
              decoration: InputDecoration(
                labelText: 'Installer Name',
                enabled: false,
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
            TextFormField(
              readOnly: true,
              initialValue: 'HK1210',
              decoration: InputDecoration(
                labelText: 'Certificate ID',
                enabled: false,
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
            TextFormField(
              readOnly: true,
              initialValue: 'Sandeep D',
              decoration: InputDecoration(
                labelText: 'Supervisor/TSE',
                enabled: false,
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
            TextFormField(
              controller: poReferenceController,
              decoration: InputDecoration(labelText: 'PO Reference'),
            ),
            TextFormField(
              controller: poDateController,
              decoration: InputDecoration(labelText: 'PO Date'),
            ),
            TextFormField(
              readOnly: true,
              initialValue: 'HKSandeep',
              decoration: InputDecoration(
                labelText: 'JCR Ref. No',
                enabled: false,
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 16),

            // Customer details
            Text(
              'Customer Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  customerName = value;
                });
              },
              decoration: InputDecoration(labelText: 'Customer name'),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  location = value;
                });
              },
              decoration: InputDecoration(labelText: 'Location'),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  department = value;
                });
              },
              decoration: InputDecoration(labelText: 'Department'),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  jobLocationAndId = value;
                });
              },
              decoration: InputDecoration(labelText: 'Job Location & ID'),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  contactPerson = value;
                });
              },
              decoration: InputDecoration(labelText: 'Contact person'),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  mobileNumber = value;
                });
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'Mobile number'),
            ),
            SizedBox(height: 16),

            // Defect & design details
            Text(
              'Defect & Design Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              value: defectType,
              items: ['Type-A', 'Type-B', 'Type-C', 'Type-D']
                  .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  defectType = value!;
                });
              },
              decoration: InputDecoration(labelText: 'Defect Type'),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  defectDetails = value;
                });
              },
              decoration: InputDecoration(labelText: 'Defect Details'),
            ),
            DropdownButtonFormField<String>(
              value: outputSheet,
              items: ['yes', 'no']
                  .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  outputSheet = value!;
                });
              },
              decoration: InputDecoration(labelText: 'Output sheet'),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  numberOfLayers = int.tryParse(value) ?? 0;
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Number of layers'),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  repairDimensions = value;
                });
              },
              decoration: InputDecoration(labelText: 'Repair dimensions'),
            ),
            DropdownButtonFormField<String>(
              value: applicationType,
              items: ['on-line', 'off-line']
                  .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  applicationType = value!;
                });
              },
              decoration: InputDecoration(labelText: 'Application type'),
            ),
            SizedBox(height: 16),

            // Save and Cancel buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle save action here
                    // You can access form values using the variables defined above
                  },
                  child: Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle cancel action here
                    // Clear form inputs and reset variables
                    setState(() {
                      poReferenceController.clear();
                      poDateController.clear();
                      jcrRefNo = 'HKSandeep';

                      customerName = '';
                      location = '';
                      department = '';
                      jobLocationAndId = '';
                      contactPerson = '';
                      mobileNumber = '';

                      defectType = 'Type-A';
                      defectDetails = '';
                      outputSheet = 'yes';
                      numberOfLayers = 0;
                      repairDimensions = '';
                      applicationType = 'on-line';
                    });
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
