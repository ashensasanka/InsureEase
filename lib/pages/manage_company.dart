import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/firestore.dart';

class ManageCompanyPage extends StatefulWidget {
  const ManageCompanyPage({super.key});

  @override
  State<ManageCompanyPage> createState() => _ManageCompanyPageState();
}

class _ManageCompanyPageState extends State<ManageCompanyPage> {
  final FireStoreService fireStoreService = FireStoreService();
  late Stream<QuerySnapshot> companyStream;
  bool _ascendingOrder = true;
  String _searchText = '';
  final TextEditingController contactNoController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController companyIdController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    companyStream = fireStoreService.getCompanyStream();
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

  void openNoteBox({String? docID}) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xfffef6eb),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: companyNameController,
                decoration: InputDecoration(
                  labelText: 'Company Name',
                ),
              ),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                ),
              ),
              TextField(
                controller: contactNoController,
                decoration: InputDecoration(
                  labelText: 'Contact No',
                ),
              ),
              TextField(
                controller: countryController,
                decoration: InputDecoration(
                  labelText: 'Country',
                ),
              ),
              TextField(
                controller: companyIdController,
                decoration: InputDecoration(
                  labelText: 'Company ID',
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              fireStoreService.updateCompany(
                docID!,
                companyNameController.text,
                addressController.text,
                contactNoController.text,
                countryController.text,
                companyIdController.text,
              );
              companyNameController.clear();
              addressController.clear();
              contactNoController.clear();
              countryController.clear();
              companyIdController.clear();
              Navigator.pop(context);
            },
            child: Text(
              "Update",
              style: TextStyle(
                color: Color(0xfff9a130),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Manage Company Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
        centerTitle: true,
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
                stream: companyStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List videosList = snapshot.data!.docs;
                    if (_searchText.isNotEmpty) {
                      videosList = videosList.where((video) {
                        final String noteText = video['supplierName'];
                        return noteText
                            .toLowerCase()
                            .contains(_searchText.toLowerCase());
                      }).toList();
                    }
                    if (!_ascendingOrder) {
                      videosList = videosList.reversed.toList();
                    }
                    return ListView.builder(
                      itemCount: videosList.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = videosList[index];
                        String docID = document.id;

                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        String videoName = data['supplierName'];
                        String thumbnail = data['supplierimageUrl'] ??
                            ''; // Get subtext or use empty string if not available

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
                                        videoName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      SizedBox(height: 4.0),
                                      Image.network(thumbnail)
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
                Text('Are you sure you want to delete this company?'),
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
