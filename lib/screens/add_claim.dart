import 'package:app/screens/widget/dropdown_selection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/dropdown.dart';

class AddClaim extends StatefulWidget {
  final String docName;
  AddClaim({super.key, required this.docName});

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
  bool isSelected = false;


  Future<void> _submitDataToFirestore() async {
    // Access Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    // Add your Firestore collection name
    CollectionReference claimDataCollection = firestore.collection('claimdata${user?.uid}');
    QuerySnapshot querySnapshot = await claimDataCollection.get();
    int claimLength = querySnapshot.docs.length;
    String registerNumber = _textFieldValue;
    double doubleValue = double.parse(registerNumber);

    // Add data to Firestore
    try {
      await claimDataCollection.doc(widget.docName).set({
        'claimIndex':claimLength,
        'vehicle': selectedVehicle,
        'model': selectedModel,
        'year': selectedYear,
        'insuranceType': selectedInsuranceType,
        'typeofAccident': selectedTypeAccident,
        'typeofIncident': selectedTypeIncident,
        'registrationNumber': doubleValue,
        'expiryDate': _dateController.text,
        'imageUrl':'',
        'claimId':'LA${widget.docName}',
        'isSelected':isSelected
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
              DropdownSelection1(
                onChanged: (value) {
                  setState(() {
                    selectedVehicle = value;
                  },);
                },
              ),

              SizedBox(height: 10,),
              Text(
                'Select Model *',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              DropdownSelection2(
                onChanged: (value) {
                  setState(() {
                    selectedModel = value;
                  },);
                },
              ),
              SizedBox(height: 10,),
              Text(
                'Select Year *',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              DropdownSelection3(
                onChanged: (value) {
                  setState(() {
                    selectedYear = value;
                  },);
                },
              ),
              SizedBox(height: 10,),
              Text(
                'Insurance Type *',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              DropdownSelection4(
                onChanged: (value) {
                  setState(() {
                    selectedInsuranceType = value;
                  },);
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
                    },);
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
              DropdownSelection5(
                onChanged: (value) {
                  setState(() {
                    selectedTypeIncident = value;
                  },);
                },
              ),
              SizedBox(height: 10,),
              Text(
                'Accident type',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              DropdownSelection6(
                onChanged: (value) {
                  setState(() {
                    selectedTypeAccident = value;
                  },);
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

