import 'package:app/pages/payment_confirm_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isChecked = false;
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardNameController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to fetch Firestore document data
  Future<void> _fetchUserData(String UID) async {
    try {
      DocumentSnapshot userSnapshot =
          await _firestore.collection('login_users').doc(UID).get();
      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        setState(() {
          cardNumberController.text =
              userData['card_number'] ?? '';
          cardNameController.text =
              userData['cardholder_name'] ?? '';
          endDateController.text =
              userData['expire_date'] ?? '';
        });
      } else {
        print('User document does not exist');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  // Function to update Firestore document
  Future<void> _updateUserData(String UID) async {
    try {
      await _firestore.collection('login_users').doc(UID).update({
        'card_number': cardNumberController.text,
        'cardholder_name': cardNameController.text,
        'expire_date': endDateController.text,
      });
      print('User data updated successfully');
    } catch (e) {
      print('Error updating user data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String UID = user.uid ?? ''; // Get the user's email
      // Now you can use the email to fetch user data
      _fetchUserData(UID);
    } else {
      print('User not logged in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffEEEEEE),
        title: Text(
          'Enter Your Payment Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
              ),
              Text(
                'Cardholder Name ',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              TextFormField(
                controller: cardNameController,
                decoration: InputDecoration(
                  hintText: 'Enter name',
                  filled: true,
                  fillColor: Colors
                      .grey[200], // Set your desired background color here
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Set the desired radius here
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Card Number ',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              TextFormField(
                controller: cardNumberController,
                decoration: InputDecoration(
                  hintText: 'Enter Card Number  ',
                  filled: true,
                  fillColor: Colors
                      .grey[200], // Set your desired background color here
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Set the desired radius here
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 50),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        'End Date',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                          height:
                              10), // Add some spacing between the text and the TextFormField
                      Container(
                        width: 150, // Set the desired width here
                        child: TextFormField(
                          controller: endDateController,
                          decoration: InputDecoration(
                            hintText: 'MM/YYYY',
                            filled: true,
                            fillColor: Colors.grey[
                                200], // Set your desired background color here
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Set the desired radius here
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  Column(
                    children: [
                      Text(
                        'CVV',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                          height:
                              10), // Add some spacing between the text and the TextFormField
                      Container(
                        width: 150, // Set the desired width here
                        child: TextFormField(
                          controller: cvvController,
                          decoration: InputDecoration(
                            hintText: 'xxx',
                            filled: true,
                            fillColor: Colors.grey[
                                200], // Set your desired background color here
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Set the desired radius here
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),

              SizedBox(
                height: 70,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 120,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      User? user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        String UID = user.uid ?? '';
                        _updateUserData(UID);
                      } else {
                        print('User not logged in');
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderPlacePage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffF9A130), // Change button color to black
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Save Card ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
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
