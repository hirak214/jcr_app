import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class PreWorkFormPage extends StatefulWidget {
  @override
  _PreWorkFormPageState createState() => _PreWorkFormPageState();
}

class _PreWorkFormPageState extends State<PreWorkFormPage> {
  final _formKey = GlobalKey<FormState>();

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

  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pre Work Form'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Installer Details
              Text(
                'Installer Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      initialValue: 'S Bharmappa',
                      decoration: InputDecoration(
                        labelText: 'Installer Name',
                        enabled: false,
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      initialValue: 'HK1210',
                      decoration: InputDecoration(
                        labelText: 'Certificate ID',
                        enabled: false,
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      initialValue: 'Sandeep D',
                      decoration: InputDecoration(
                        labelText: 'Supervisor/TSE',
                        enabled: false,
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: poReferenceController,
                      decoration: InputDecoration(labelText: 'PO Reference'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter PO Reference';
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: poDateController,
                      decoration: InputDecoration(labelText: 'PO Date'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter PO Date';
                        }
                        // You can add additional date format validation here
                        return null;
                      },
                    ),
                  ),
                ],
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Customer Name';
                  }
                  return null;
                },
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    location = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Location';
                  }
                  return null;
                },
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    department = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Department'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Department';
                  }
                  return null;
                },
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    jobLocationAndId = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Job Location & ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Job Location & ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    contactPerson = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Contact person'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Contact Person';
                  }
                  return null;
                },
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    mobileNumber = value;
                  });
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Mobile number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Mobile Number';
                  }
                  if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                    return 'Please enter a valid 10-digit Mobile Number';
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value == null) {
                    return 'Please select Defect Type';
                  }
                  return null;
                },
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    defectDetails = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Defect Details'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Defect Details';
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value == null) {
                    return 'Please select Output sheet';
                  }
                  return null;
                },
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    numberOfLayers = int.tryParse(value) ?? 0;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Number of layers'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Number of layers';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid numerical value';
                  }
                  return null;
                },
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    repairDimensions = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Repair dimensions'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Repair dimensions';
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value == null) {
                    return 'Please select Application type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Image picker
              Text(
                'Images Before the Job',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 16),

              _pickedImage == null
                  ? ElevatedButton(
                onPressed: () async {
                  final pickedImage = await ImagePicker().getImage(
                    source: ImageSource.gallery, // You can change this to ImageSource.camera for the camera.
                  );

                  if (pickedImage != null) {
                    setState(() {
                      _pickedImage = File(pickedImage.path);
                    });
                  }
                },
                child: Text('Pick an Image'),
              )
                  : Image.file(
                _pickedImage!,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),

              SizedBox(height: 16),

              // Save and Cancel buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle save action here
                        final formData = {
                          'poReference': poReferenceController.text,
                          'poDate': poDateController.text,
                          'jcrRefNo': jcrRefNo,
                          'customerName': customerName,
                          'location': location,
                          'department': department,
                          'jobLocationAndId': jobLocationAndId,
                          'contactPerson': contactPerson,
                          'mobileNumber': mobileNumber,
                          'defectType': defectType,
                          'defectDetails': defectDetails,
                          'outputSheet': outputSheet,
                          'numberOfLayers': numberOfLayers,
                          'repairDimensions': repairDimensions,
                          'applicationType': applicationType,
                        };

                        saveToJsonFile(formData);
                        // Optionally, show a confirmation message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Form data saved successfully.'),
                          ),
                        );
                      }
                    },
                    child: Text('Save'),
                  ),
        ElevatedButton(
          onPressed: () {
            // Clear form inputs and reset variables
            _formKey.currentState!.reset();
            setState(() {
              // Clear text controllers
              poReferenceController.clear();
              poDateController.clear();

              // Reset other variables
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

              // Clear the picked image
              _pickedImage = null;
            });

            // Close the form and return to the previous screen (dashboard)
            Navigator.pop(context);
          },
          child: Text('Cancel'),
      ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveToJsonFile(Map<String, dynamic> formData) {
    final jsonString = json.encode(formData);
    final file = File('form_data.json'); // Change the file path as needed

    file.writeAsStringSync(jsonString);
  }

}
