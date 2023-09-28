import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ActivityFormPage extends StatefulWidget {
  @override
  _ActivityFormPageState createState() => _ActivityFormPageState();
}

class _ActivityFormPageState extends State<ActivityFormPage> {
  TextEditingController jobDateController = TextEditingController();
  String preCleaning = 'Solvent Cleaning';
  String surfacePreparationMethod = '';
  String relativeHumidity = '';
  String surfaceTemperature = '';
  String impregnation = 'Yes (with spike roller)';
  String peelPly = 'used';
  String totalAreaRepaired = '';

  String productName = '';
  String resin = 'Loctite PC 7210-A';
  String hardener = 'Loctite PC 7210-B';
  String glassCarbonTape = 'Loctite PC 5085';
  String topCoat = 'Loctite PC 7333';

  String productBatchNo = '';
  TextEditingController expiryDateController = TextEditingController();
  String consumption = '';
  String productMixing = 'Full Mixing';
  String curingTime = '';

  File? _pickedImageDuringJob;
  File? _pickedImageAfterJob;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity Form'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Job Details
              Text(
                'Job Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: jobDateController,
                decoration: InputDecoration(labelText: 'Job Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid Job Date.';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: preCleaning,
                items: ['Solvent Cleaning', 'Water Jet Cleaning', 'Chipping']
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    preCleaning = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Pre-Cleaning'),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    surfacePreparationMethod = value;
                  });
                },
                decoration:
                InputDecoration(labelText: 'Surface Preparation method'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid Surface Preparation method.';
                  }
                  return null;
                },
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    relativeHumidity = value;
                  });
                },
                keyboardType: TextInputType.number,
                decoration:
                InputDecoration(labelText: 'Relative Humidity in %'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid Relative Humidity.';
                  }
                  final numValue = int.tryParse(value);
                  if (numValue == null || numValue < 1 || numValue > 100) {
                    return 'Please enter a number between 1 and 100.';
                  }
                  return null;
                },
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    surfaceTemperature = value;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Surface Temperature'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid Surface Temperature.';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: impregnation,
                items: ['Yes (with spike roller)', 'No']
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    impregnation = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Impregnation'),
              ),
              DropdownButtonFormField<String>(
                value: peelPly,
                items: ['used', 'not used']
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    peelPly = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Peel ply'),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    totalAreaRepaired = value;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Total area repaired'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid Total area repaired.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Product Details
              Text(
                'Product Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Resin',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<String>(
                value: resin,
                items: ['Loctite PC 7210-A', 'Loctite PC 7211-A']
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    resin = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a Resin.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Hardener',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<String>(
                value: hardener,
                items: ['Loctite PC 7210-B', 'Loctite PC 7211-B']
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    hardener = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a Hardener.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Glass Carbon Tape',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<String>(
                value: glassCarbonTape,
                items: ['Loctite PC 5085', 'Loctite PC 5089']
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    glassCarbonTape = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a Glass Carbon Tape.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Top Coat',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<String>(
                value: topCoat,
                items: ['Loctite PC 7333', 'Loctite PC 7443']
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    topCoat = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a Top Coat.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Product batch no'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid Product batch no.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: expiryDateController,
                decoration: InputDecoration(labelText: 'Expiry date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid Expiry Date.';
                  }
                  // Add additional validation for date format if needed
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Consumption'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid Consumption.';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: productMixing,
                items: ['Full Mixing', 'Part Mixing']
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    productMixing = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Product mixing'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a Product mixing option.';
                  }
                  return null;
                },
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    curingTime = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Curing time'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid Curing time.';
                  }
                  return null;
                },
              ),

              // Images During Job
              SizedBox(height: 16),
              Text(
                'Images During Job',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              _pickedImageDuringJob == null
                  ? ElevatedButton(
                onPressed: () async {
                  final pickedImage = await ImagePicker().getImage(
                    source: ImageSource.gallery,
                  );

                  if (pickedImage != null) {
                    setState(() {
                      _pickedImageDuringJob =
                          File(pickedImage.path);
                    });
                  }
                },
                child: Text('Pick an Image During Job'),
              )
                  : Image.file(
                _pickedImageDuringJob!,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),

              // Images After Job
              SizedBox(height: 16),
              Text(
                'Images After Job',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              _pickedImageAfterJob == null
                  ? ElevatedButton(
                onPressed: () async {
                  final pickedImage = await ImagePicker().getImage(
                    source: ImageSource.gallery,
                  );

                  if (pickedImage != null) {
                    setState(() {
                      _pickedImageAfterJob =
                          File(pickedImage.path);
                    });
                  }
                },
                child: Text('Pick an Image After Job'),
              )
                  : Image.file(
                _pickedImageAfterJob!,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),

              // Save and Submit buttons
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle save action here without validation
                      // You can access form values using the variables defined above
                    },
                    child: Text('Save'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // The form is valid, you can handle submit action here
                        // You can access form values using the variables defined above
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
