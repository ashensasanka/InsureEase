import 'package:app/screens/widget/dropdown_selection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddClaim extends StatefulWidget {
  const AddClaim({super.key});

  @override
  State<AddClaim> createState() => _AddClaimState();
}

class _AddClaimState extends State<AddClaim> {
  String _textFieldValue = '';
  late TextEditingController _dateController;
  late DateTime selectedDate;
  String selectedVehicle = '';
  String selectedModel = '';
  String selectedYear = '';
  String selectedInsuranceType = '';
  String selectedTypeAccident = '';
  String selectedTypeIncident = '';


  Future<void> _submitDataToFirestore() async {
    // Access Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    // Add your Firestore collection name
    CollectionReference claimDataCollection = firestore.collection('claimdata${user?.uid}');

    // Add data to Firestore
    try {
      await claimDataCollection.add({
        'vehicle': selectedVehicle,
        'model': selectedModel,
        'year': selectedYear,
        'insuranceType': selectedInsuranceType,
        'typeofAccident': selectedTypeAccident,
        'typeofIncident': selectedTypeIncident,
        'registrationNumber': _textFieldValue,
        'expiryDate': _dateController.text,
        // Add other fields as needed
      });
      setState(() {
        selectedVehicle = '';
        selectedModel = '';
        selectedYear = '';
        selectedInsuranceType = '';
        selectedTypeAccident = '';
        selectedTypeIncident = '';
        _textFieldValue = '';
        selectedDate = DateTime.now();
        _dateController.text = _formatDate(selectedDate);
      });
      print('Data submitted to Firestore successfully!');
    } catch (e) {
      print('Error submitting data to Firestore: $e');
    }
  }



  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    _dateController = TextEditingController(text: _formatDate(selectedDate));
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = _formatDate(selectedDate); // Update text field
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Select Vehicle *',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              DropdownSelection(
                onChanged: (value) {
                  setState(() {
                    selectedVehicle = value;
                  });
                },
              ),

              SizedBox(height: 10,),
              Text(
                'Select Model *',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              DropdownSelection(
                onChanged: (value) {
                  setState(() {
                    selectedModel = value;
                  });
                },
              ),
              SizedBox(height: 10,),
              Text(
                'Select Year *',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              DropdownSelection(
                onChanged: (value) {
                  setState(() {
                    selectedYear = value;
                  });
                },
              ),
              SizedBox(height: 10,),
              Text(
                'Insurance Type *',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              DropdownSelection(
                onChanged: (value) {
                  setState(() {
                    selectedInsuranceType = value;
                  });
                },
              ),
              SizedBox(height: 10,),
              Text(
                'Registration Number *',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Container(
                width: 250, // Set the desired width
                height: 42, // Set the desired height
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _textFieldValue = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter Number',
                    hintText: 'Enter XXXX',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text(
                'Expiry Date *',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Container(
                width: 250, // Set the desired width
                height: 42,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _dateController, // Use the controller
                        readOnly: true, // Make the text field read-only
                        decoration: InputDecoration(
                          labelText: 'Date',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _selectDate(context),
                      icon: Icon(
                        Icons.calendar_today,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Text(
                'What type of Incident occured?',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              DropdownSelection(
                onChanged: (value) {
                  setState(() {
                    selectedTypeIncident = value;
                  });
                },
              ),
              SizedBox(height: 10,),
              Text(
                'Accident type',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              DropdownSelection(
                onChanged: (value) {
                  setState(() {
                    selectedTypeAccident = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  _submitDataToFirestore();
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class DropdownSelection extends StatefulWidget {
  final Function(String) onChanged;

  const DropdownSelection({required this.onChanged});

  @override
  _DropdownSelectionState createState() => _DropdownSelectionState();
}


class _DropdownSelectionState extends State<DropdownSelection> {
  String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 42,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButton<String>(
              value: selectedValue,
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue!;
                  widget.onChanged(selectedValue); // Pass selected value to parent widget
                });
              },

              icon: Icon(
                Icons.arrow_drop_down,
                size: 1,
              ), // Remove the default dropdown icon
              items: <String>[
                '',
                'Option 1',
                'Option 2',
                'Option 3',
                'Option 4'
              ].map<DropdownMenuItem<String>>(
                    (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),
          ),
          Icon(
            Icons.arrow_drop_down,
          ), // Icon aligned to the right corner
        ],
      ),
    );
  }
}