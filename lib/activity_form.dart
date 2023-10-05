import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class ActivityFormPage extends StatefulWidget {
  final String poReference;

  ActivityFormPage({
    required this.poReference,
  });

  @override
  _ActivityFormPageState createState() => _ActivityFormPageState();
}

class _ActivityFormPageState extends State<ActivityFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _pickedImageDuringJob = null;
  File? _pickedImageAfterJob = null;
  late TextEditingController jobDateController = TextEditingController();

  late TextEditingController surfacePreparationController = TextEditingController();
  late String preCleaning = 'Solvent Cleaning';
  late String surfacePreparationMethod = 'Solvent Cleaning';
  late String relativeHumidity = '0';
  late String surfaceTemperature = '0';
  late String impregnation = 'Yes (with spike roller)';
  late String peelPly = 'used';
  late String totalAreaRepaired = '0';
  late String productName = 'Loctite PC 7210-A';
  late String resin = 'Loctite PC 7210-A';
  late String hardener = 'Loctite PC 7210-B';
  late String glassCarbonTape = 'Loctite PC 5085';
  late String topCoat = 'Loctite PC 7333';
  late String productBatchNo = '';
  late TextEditingController expiryDateController = TextEditingController();
  late String consumption = '0';
  late String productMixing = 'Full Mixing';
  late String curingTime = '0';
  late DateTime? selectedJobDate = DateTime.now();
  late DateTime? selectedExpiryDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    jobDateController = TextEditingController();
    surfacePreparationController = TextEditingController();
    loadExistingFormData();
  }

  Future<void> loadExistingFormData() async {
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

        // Find the existing form data by matching the poReference
        final existingForm = formDataList.firstWhere(
              (formData) => formData['poReference'] == widget.poReference,
          orElse: () => {
            'jobDate': '',
            'preCleaning': 'Solvent Cleaning', // Set default values here
            'surfacePreparationMethod': '',
            'relativeHumidity': '0',
            'surfaceTemperature': '0',
            'impregnation': 'Yes (with spike roller)',
            'peelPly': 'used',
            'totalAreaRepaired': '0',
            'productName': 'Loctite PC 7210-A',
            'resin': 'Loctite PC 7210-A',
            'hardener': 'Loctite PC 7210-B',
            'glassCarbonTape': 'Loctite PC 5085',
            'topCoat': 'Loctite PC 7333',
            'productBatchNo': '',
            'expiryDate': '',
            'consumption': '0',
            'productMixing': 'Full Mixing',
            'curingTime': '0',
            'poReference': widget.poReference, // Include the poReference in the form data
            'imagesDuringJob': [],
            'imagesAfterJob': [],
            // Add default values for other form fields
          },
        );

        setState(() {
          jobDateController.text = existingForm['jobDate'];
          surfacePreparationController.text = existingForm['surfacePreparationMethod'];
          preCleaning = existingForm['preCleaning'];
          surfacePreparationMethod = existingForm['surfacePreparationMethod'];
          relativeHumidity = existingForm['relativeHumidity'];
          surfaceTemperature = existingForm['surfaceTemperature'];
          impregnation = existingForm['impregnation'];
          peelPly = existingForm['peelPly'];
          totalAreaRepaired = existingForm['totalAreaRepaired'];
          productName = existingForm['productName'];
          resin = existingForm['resin'];
          hardener = existingForm['hardener'];
          glassCarbonTape = existingForm['glassCarbonTape'];
          topCoat = existingForm['topCoat'];
          productBatchNo = existingForm['productBatchNo'];
          expiryDateController.text = existingForm['expiryDate'];
          consumption = existingForm['consumption'];
          productMixing = existingForm['productMixing'];
          curingTime = existingForm['curingTime'];
        });
      }
    } catch (e) {
      print('Error loading existing form data: $e');
      // Handle the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity Form for ${widget.poReference}'), // Use the poReference in the title
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
                        text: selectedJobDate?.toLocal().toString().split(' ')[0] ?? '',
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
                      controller: surfacePreparationController,
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
                      saveFormData();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Form data saved successfully.'),
                        ),
                      );

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

  Map<String, dynamic> getActivityFormData() {
    return {
      'poReference': widget.poReference, // Include the poReference
      'jobDate': selectedJobDate?.toLocal().toString().split(' ')[0] ?? '',
      'preCleaning': preCleaning,
      'surfacePreparationMethod': surfacePreparationMethod,
      'relativeHumidity': relativeHumidity,
      'surfaceTemperature': surfaceTemperature,
      'impregnation': impregnation,
      'peelPly': peelPly,
      'totalAreaRepaired': totalAreaRepaired,
      'productName': productName,
      'resin': resin,
      'hardener': hardener,
      'glassCarbonTape': glassCarbonTape,
      'topCoat': topCoat,
      'productBatchNo': productBatchNo,
      'expiryDate': selectedExpiryDate?.toLocal().toString().split(' ')[0] ?? '',
      'consumption': consumption,
      'productMixing': productMixing,
      'curingTime': curingTime,
      'imagesDuringJob': _pickedImageDuringJob?.path ?? '',
      'imagesAfterJob': _pickedImageAfterJob?.path ?? '',
    };
  }

  Future<void> saveFormData() async {
    try {
      final directory = await getExternalStorageDirectory();
      if (directory == null) {
        return; // Handle error, unable to access storage directory
      }

      final filePath = '${directory.path}/activity_form_data.json';
      final file = File(filePath);

      List<dynamic> formDataList = [];

      // Check if the file already exists
      if (await file.exists()) {
        final jsonData = await file.readAsString();
        formDataList = json.decode(jsonData);
      }

      // Find the existing form data by matching the poReference
      final existingIndex = formDataList.indexWhere(
            (formData) => formData['poReference'] == widget.poReference,
      );

      // Add or update the form data
      if (existingIndex != -1) {
        formDataList[existingIndex] = getActivityFormData();
      } else {
        formDataList.add(getActivityFormData());
      }

      // Write the updated data back to the file
      await file.writeAsString(json.encode(formDataList));
    } catch (e) {
      print('Error saving form data: $e');
      // Handle the error
    }
  }
}
