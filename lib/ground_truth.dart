import 'package:flutter/material.dart';

class CustomDropdownWithCheckboxes extends StatefulWidget {
  final List<String> models;
  final List<bool> checkedModels;

  const CustomDropdownWithCheckboxes({
    required this.models,
    required this.checkedModels,
  });

  @override
  _CustomDropdownWithCheckboxesState createState() =>
      _CustomDropdownWithCheckboxesState();
}

class _CustomDropdownWithCheckboxesState
    extends State<CustomDropdownWithCheckboxes> {
  bool dropdownOpened = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              dropdownOpened = !dropdownOpened;
            });
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromARGB(255, 131, 1, 253)),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Models'),
                Icon(dropdownOpened
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        dropdownOpened
            ? Column(
                children: widget.models.asMap().entries.map((entry) {
                  int index = entry.key;
                  String model = entry.value;
                  return CheckboxListTile(
                    title: Text(model),
                    value: widget.checkedModels[index],
                    onChanged: (bool? value) {
                      setState(() {
                        widget.checkedModels[index] = value ?? false;
                      });
                    },
                  );
                }).toList(),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}

class GroundTruthPage extends StatefulWidget {
  @override
  _GroundTruthPageState createState() => _GroundTruthPageState();
}

class _GroundTruthPageState extends State<GroundTruthPage> {
  // Define the list of patients and models
  List<String> patients = [
    'Patient 1',
    'Patient 2',
    'Patient 3',
    'Patient 4',
    'Patient 5'
  ];
  List<String> models = ['SVM', 'Decision Tree', 'XGBoost', 'Random Forest'];

  // Keep track of selected patient and model
  String selectedPatient = 'Patient 1';
  List<bool> checkedModels = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ground Truth'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown for selecting patients
            DropdownButton<String>(
              value: selectedPatient,
              onChanged: (newValue) {
                setState(() {
                  selectedPatient = newValue!;
                });
              },
              items: patients.map<DropdownMenuItem<String>>((String patient) {
                return DropdownMenuItem<String>(
                  value: patient,
                  child: Text(patient),
                );
              }).toList(),
            ),
            SizedBox(height: 20), // Add space between dropdowns

            // Custom dropdown with checkboxes for selecting models
            CustomDropdownWithCheckboxes(
              models: models,
              checkedModels: checkedModels,
            ),
            SizedBox(height: 20), // Add space between dropdown and checkboxes
          ],
        ),
      ),
    );
  }
}
