import 'package:app/pages/select_user_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../services/firestore.dart';

class UpdatePremiumPage extends StatefulWidget {
  const UpdatePremiumPage({super.key});

  @override
  State<UpdatePremiumPage> createState() => _UpdatePremiumPageState();
}

class _UpdatePremiumPageState extends State<UpdatePremiumPage> {
  final FireStoreService fireStoreService = FireStoreService();
  final TextEditingController premiumController = TextEditingController();
  final TextEditingController taxesController = TextEditingController();
  late Stream<QuerySnapshot> userStream;
  String _searchText = '';
  bool _ascendingOrder = true;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    userStream = fireStoreService.getUserStream();
  }

  void openNoteBox({String? docID}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference userDataCollection =
        firestore.collection('login_users');
    QuerySnapshot querySnapshot = await userDataCollection.get();
    int userLength = querySnapshot.docs.length;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xfffef6eb),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                keyboardType: TextInputType.number,
                controller: premiumController,
                decoration: InputDecoration(
                  prefixText: 'Rs: ',
                  labelText: 'Premium Rs:',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller:
                    taxesController, // Use subtextController for subtext TextField
                decoration: InputDecoration(
                  prefixText: 'Rs: ',
                  labelText: 'Taxes Rs:',
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              fireStoreService.updatePremium(
                  docID!, premiumController.text, taxesController.text);

              premiumController.clear();
              taxesController.clear();
              Navigator.pop(context);
            },
            child: Text(
              "Sumbit",
              style: TextStyle(
                color: Color(0xfff9a130),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      onChanged: (value) {
        setState(
          () {
            _searchText = value;
          },
        );
      },
      decoration: InputDecoration(
        labelText: 'Search',
        hintText: 'Search supplier...',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfffef6eb),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _ascendingOrder = !_ascendingOrder;
                });
              },
              icon: Icon(
                  _ascendingOrder ? Icons.arrow_upward : Icons.arrow_downward),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
              },
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xfff9a130),
          onPressed: openNoteBox,
          child: Icon(Icons.add),
        ),
        body: Container(
          color: Color(0xfffef6eb),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: _buildSearchBar(),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: userStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List userList = snapshot.data!.docs;
                      if (_searchText.isNotEmpty) {
                        userList = userList.where(
                          (note) {
                            final String nameText = note['name'];
                            return nameText
                                .toLowerCase()
                                .contains(_searchText.toLowerCase());
                          },
                        ).toList();
                      }
                      if (!_ascendingOrder) {
                        userList = userList.reversed.toList();
                      }
                      return ListView.builder(
                        itemCount: userList.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot document = userList[index];
                          String docID = document.id;

                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          String noteText = data['name'];
                          String subtext = data['email'] ?? '';

                          return Padding(
                            padding: EdgeInsets.only(
                                bottom: 8.0,
                                left: 8,
                                right: 8), // Add space between items
                            child: Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Adjust the radius as needed
                                child: Container(
                                  color: Color(0xfff9a130),
                                  child: ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          noteText,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        SizedBox(height: 4.0),
                                        Text(
                                          subtext,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () =>
                                              openNoteBox(docID: docID),
                                          icon: Icon(Icons.settings),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text("No Users!"));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
