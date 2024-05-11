import 'package:app/pages/select_user_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../services/firestore.dart';

class ClaimAgentPage extends StatefulWidget {
  const ClaimAgentPage({super.key});

  @override
  State<ClaimAgentPage> createState() => _ClaimAgentPageState();
}

class _ClaimAgentPageState extends State<ClaimAgentPage> {
  final FireStoreService fireStoreService = FireStoreService();
  final TextEditingController suppNameController = TextEditingController();
  final TextEditingController suppAddressController = TextEditingController();
  final TextEditingController suppCountryController = TextEditingController();
  final TextEditingController suppContactController = TextEditingController();
  late Stream<QuerySnapshot> supplierStream;
  String _searchText = '';
  bool _ascendingOrder = true;
  bool _isDarkMode = false;
  File? _image;

  @override
  void initState() {
    super.initState();
    supplierStream = fireStoreService.getSupplierStream();
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void openNoteBox({String? docID}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference claimDataCollection = firestore.collection('suppliers');
    QuerySnapshot querySnapshot = await claimDataCollection.get();
    int supplierLength = querySnapshot.docs.length;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xfffef6eb),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: suppNameController,
                decoration: InputDecoration(
                  labelText: 'Supplier Name',
                ),
              ),
              TextField(
                controller:
                    suppAddressController, // Use subtextController for subtext TextField
                decoration: InputDecoration(
                  labelText: 'Supplier Address',
                ),
              ),
              TextField(
                controller:
                    suppCountryController, // Use subtextController for subtext TextField
                decoration: InputDecoration(
                  labelText: 'Supplier Country',
                ),
              ),
              TextField(
                controller:
                    suppContactController, // Use subtextController for subtext TextField
                decoration: InputDecoration(
                  labelText: 'Supplier Contact No',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: _getImageFromGallery,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white, // Set the background color
                    borderRadius:
                        BorderRadius.circular(20), // Round the borders
                  ),
                  child: _image != null
                      ? Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          Icons
                              .add_photo_alternate, // Add an icon for image selection
                          size: 50,
                          color: Colors.grey, // Set the icon color
                        ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (docID == null) {
                fireStoreService.addSupplier(
                    suppNameController.text,
                    suppAddressController.text,
                    suppCountryController.text,
                    suppContactController.text,
                    supplierLength,
                    _image,
                    'image');
                Fluttertoast.showToast(
                  msg: "Supplier added successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                );
              } else {
                fireStoreService.updateAdminNote(
                    docID,
                    suppNameController.text,
                    suppAddressController.text,
                    suppCountryController.text,
                    suppContactController.text);
              }
              suppNameController.clear();
              suppAddressController.clear();
              suppCountryController.clear();
              suppContactController.clear();
              Navigator.pop(context);
            },
            child: Text(
              "Add Supplier",
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
        setState(() {
          _searchText = value;
        });
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
          backgroundColor: Color(0xfff9a130),
          title: Text("Details of Supplier"),
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
                  stream: supplierStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List notesList = snapshot.data!.docs;
                      if (_searchText.isNotEmpty) {
                        notesList = notesList.where((note) {
                          final String noteText = note['supplierName'];
                          return noteText.toLowerCase().contains(_searchText.toLowerCase());
                        }).toList();
                      }
                      if (!_ascendingOrder) {
                        notesList = notesList.reversed.toList();
                      }
                      return ListView.builder(
                        itemCount: notesList.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot document = notesList[index];
                          String docID = document.id;

                          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                          String noteText = data['supplierName'];
                          String subtext = data['supplierAddress'] ?? ''; // Get subtext or use empty string if not available

                          return Padding(
                            padding: EdgeInsets.only(bottom: 8.0,left: 8,right: 8), // Add space between items
                            child: Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                                child: Container(
                                  color: Color(0xfff9a130),
                                  child: ListTile(
                                    title: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                          onPressed: () => openNoteBox(docID: docID),
                                          icon: Icon(Icons.settings),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            _confirmDelete(context, docID);
                                          },
                                          icon: Icon(Icons.delete),
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
                      return const Center(child: Text("No Notes!"));
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

  Future<void> _confirmDelete(BuildContext context, String docID) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this supplier?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                fireStoreService.deleteCompany(docID);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
