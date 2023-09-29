import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
// import 'package:intl/intl.dart';

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

  DateTime? selectedJobDate; // Add a DateTime variable for Job Date
  DateTime? selectedExpiryDate; // Add a DateTime variable for Expiry Date

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Form'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Job Details
              const Text(
                'Job Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // Row 1
              Row(
                children: [
                  // Job Date Picker
                  Expanded(
                    child: TextFormField(
                      controller: TextEditingController(
                        text: selectedJobDate?.toLocal().toString().split(
                            ' ')[0] ?? '',
                      ),
                      readOnly: true,
                      onTap: () async {
                        final currentDate = DateTime.now();
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedJobDate ?? currentDate,
                          firstDate: currentDate.subtract(Duration(days: 365)),
                          lastDate: currentDate.add(Duration(days: 365)),
                        );

                        if (selectedDate != null) {
                          setState(() {
                            selectedJobDate = selectedDate;
                          });
                        }
                      },
                      decoration: InputDecoration(labelText: 'Job Date'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Job Date';
                        }
                        // You can add additional date format validation here
                        return null;
                      },
                    ),
                  ),
                  // Pre Cleaning Dropdown
                  Expanded(
                    child: DropdownButtonFormField<String>(
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
                      decoration: const InputDecoration(labelText: 'Pre-Cleaning'),
                    ),
                  ),
                ],
              ),
              // Row 2
              Row(
                children: [
                  // Surface Preparation Method
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          surfacePreparationMethod = value;
                        });
                      },
                      decoration:
                      const InputDecoration(labelText: 'Surface Preparation method'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid Surface Preparation method.';
                        }
                        return null;
                      },
                    ),
                  ),
                  // Relative Humidity
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          relativeHumidity = value;
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration:
                      const InputDecoration(labelText: 'Relative Humidity in %'),
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
                  ),
                ],
              ),
              // Row 3
              Row(
                children: [
                  // Surface Temperature
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          surfaceTemperature = value;
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Surface Temperature'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid Surface Temperature.';
                        }
                        return null;
                      },
                    ),
                  ),
                  // Impregnation Dropdown
                  Expanded(
                    child: DropdownButtonFormField<String>(
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
                      decoration: const InputDecoration(labelText: 'Impregnation'),
                    ),
                  ),
                ],
              ),
              // Row 4
              Row(
                children: [
                  // Peel Ply Dropdown
                  Expanded(
                    child: DropdownButtonFormField<String>(
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
                      decoration: const InputDecoration(labelText: 'Peel ply'),
                    ),
                  ),
                  // Total Area Repaired
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          totalAreaRepaired = value;
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Total area repaired'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid Total area repaired.';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Product Details
              const Text(
                'Product Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              // Row 5
              Row(
                children: [
                  // Resin Dropdown
                  Expanded(
                    child: DropdownButtonFormField<String>(
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
                  ),
                  // Hardener Dropdown
                  Expanded(
                    child: DropdownButtonFormField<String>(
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
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Row 6
              Row(
                children: [
                  // Glass Carbon Tape Dropdown
                  Expanded(
                    child: DropdownButtonFormField<String>(
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
                  ),
                  // Top Coat Dropdown
                  Expanded(
                    child: DropdownButtonFormField<String>(
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
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Row 7
              Row(
                children: [
                  // Product Batch No
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          productBatchNo = value;
                        });
                      },
                      decoration: const InputDecoration(labelText: 'Product batch no'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid Product batch no.';
                        }
                        return null;
                      },
                    ),
                  ),
                  // Expiry Date Picker
                  Expanded(
                    child: TextFormField(
                      controller: TextEditingController(
                        text: selectedExpiryDate?.toLocal().toString().split(
                            ' ')[0] ?? '',
                      ),
                      readOnly: true,
                      onTap: () async {
                        final currentDate = DateTime.now();
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedExpiryDate ?? currentDate,
                          firstDate: currentDate.subtract(Duration(days: 365)),
                          lastDate: currentDate.add(Duration(days: 365)),
                        );

                        if (selectedDate != null) {
                          setState(() {
                            selectedExpiryDate = selectedDate;
                          });
                        }
                      },
                      decoration: InputDecoration(labelText: 'Expiry Date'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Expiry Date';
                        }
                        // You can add additional date format validation here
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              // Row 8
              Row(
                children: [
                  // Consumption
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          consumption = value;
                        });
                      },
                      decoration: const InputDecoration(labelText: 'Consumption'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid Consumption.';
                        }
                        return null;
                      },
                    ),
                  ),
                  // Product Mixing Dropdown
                  Expanded(
                    child: DropdownButtonFormField<String>(
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
                      decoration: const InputDecoration(labelText: 'Product mixing'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a Product mixing option.';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              // Row 9
              Row(
                children: [
                  // Curing Time
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          curingTime = value;
                        });
                      },
                      decoration: const InputDecoration(labelText: 'Curing time'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid Curing time.';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              // Images During Job
              const SizedBox(height: 16),
              const Text(
                'Images During Job',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _pickedImageDuringJob == null
                  ? ElevatedButton(
                onPressed: () async {
                  final pickedImage = await ImagePicker().getImage(
                    source: ImageSource.gallery,
                  );

                  if (pickedImage != null) {
                    setState(() {
                      _pickedImageDuringJob = File(pickedImage.path);
                    });
                  }
                },
                child: const Text('Pick an Image During Job'),
              )
                  : Image.file(
                _pickedImageDuringJob!,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),

              // Images After Job
              const SizedBox(height: 16),
              const Text(
                'Images After Job',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _pickedImageAfterJob == null
                  ? ElevatedButton(
                onPressed: () async {
                  final pickedImage = await ImagePicker().getImage(
                    source: ImageSource.gallery,
                  );

                  if (pickedImage != null) {
                    setState(() {
                      _pickedImageAfterJob = File(pickedImage.path);
                    });
                  }
                },
                child: const Text('Pick an Image After Job'),
              )
                  : Image.file(
                _pickedImageAfterJob!,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),

              // Save and Submit buttons
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle save action here without validation
                      // You can access form values using the variables defined above
                    },
                    child: const Text('Save'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // The form is valid, you can handle submit action here
                        // You can access form values using the variables defined above
                      }
                    },
                    child: const Text('Submit'),
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
