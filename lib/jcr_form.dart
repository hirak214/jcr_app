import 'package:flutter/material.dart';

void main() {
  runApp(JCRApp());
}

class JCRApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: JCRForm(),
    );
  }
}

class JCRForm extends StatefulWidget {
  @override
  _JCRFormState createState() => _JCRFormState();
}

class _JCRFormState extends State<JCRForm> {
  String? selectedDefectType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JCR Form'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Installer Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            InstallerDetailsFields(),
            SizedBox(height: 16),
            Text(
              'Customer Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            CustomerDetailsFields(),
            SizedBox(height: 16),
            Text(
              'Defect & Design Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DefectDetailsFields(),
            SizedBox(height: 16),
            Text(
              'Job Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            JobDetailsFields(),
            SizedBox(height: 16),
            Text(
              'Product Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ProductDetailsFields(),
            SizedBox(height: 16),
            Text(
              'Images',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ImageUploadFields(),
            SizedBox(height: 16),
            Text(
              'Personnel',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            PersonnelFields(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle form submission
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class InstallerDetailsFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Installer Name'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Certificate ID'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Supervisor/TSE'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'PO Reference'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'PO Date'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'JCR Ref. No'),
        ),
      ],
    );
  }
}

class CustomerDetailsFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Customer Name'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Location'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Department'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Job Location & ID'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Contact Person'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Mobile Number'),
        ),
      ],
    );
  }
}

class DefectDetailsFields extends StatefulWidget {
  @override
  _DefectDetailsFieldsState createState() => _DefectDetailsFieldsState();
}

class _DefectDetailsFieldsState extends State<DefectDetailsFields> {
  String? selectedDefectType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: selectedDefectType,
          items: ["Type-A", "Type-B", "Type-C", "Type-D"]
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          decoration: InputDecoration(labelText: 'Defect Type'),
          onChanged: (String? newValue) {
            setState(() {
              selectedDefectType = newValue;
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Defect Details'),
        ),
        Row(
          children: [
            Text('Output Sheet'),
            Checkbox(value: false, onChanged: (bool? value) {}),
          ],
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Number of Layers'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Repair Dimensions'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Application Type'),
        ),
      ],
    );
  }
}

class JobDetailsFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Job Date'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Pre-Cleaning'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Surface Preparation Method'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Relative Humidity (%)'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Surface Temperature'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Impregnation'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Peel Ply'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Total Area Repaired (String)'),
        ),
      ],
    );
  }
}

class ProductDetailsFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Product Name'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Product Batch No'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Expiry Date'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Consumption'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Product Mixing'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Curing Time'),
        ),
      ],
    );
  }
}

class ImageUploadFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Images Before Job'),
        ElevatedButton(
          onPressed: () {
            // Implement image upload logic
          },
          child: Text('Upload'),
        ),
        Text('Images During Job'),
        ElevatedButton(
          onPressed: () {
            // Implement image upload logic
          },
          child: Text('Upload'),
        ),
        Text('Images After Job'),
        ElevatedButton(
          onPressed: () {
            // Implement image upload logic
          },
          child: Text('Upload'),
        ),
      ],
    );
  }
}

class PersonnelFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Installer'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Supervisor/TSE'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Customer in Charge'),
        ),
      ],
    );
  }
}
