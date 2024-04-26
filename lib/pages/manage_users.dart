import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/firestore.dart';

class ManageUsersPage extends StatefulWidget {
  const ManageUsersPage({super.key});

  @override
  State<ManageUsersPage> createState() => _ManageUsersPageState();
}

class _ManageUsersPageState extends State<ManageUsersPage> {
  final FireStoreService fireStoreService = FireStoreService();
  late Stream<QuerySnapshot> customerStream;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Manage Customer Details",
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
              child: FutureBuilder(
                future: fireStoreService.getUsers(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    List userList = snapshot.data!.docs;
                    if (_searchText.isNotEmpty) {
                      userList = userList.where((note) {
                        final String noteText = note['name'];
                        return noteText
                            .toLowerCase()
                            .contains(_searchText.toLowerCase());
                      }).toList();
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
                    return const Center(child: Text("No Users!"));
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
                Text('Are you sure you want to delete this user?'),
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
                fireStoreService.deleteUser(docID);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
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
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Edit email',
                ),
              ),
              TextField(
                controller:
                    nameController, // Use subtextController for subtext TextField
                decoration: InputDecoration(
                  labelText: 'Edit Name',
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              fireStoreService.updateUser(
                docID!,
                nameController.text,
                emailController.text,
              );
              emailController.clear();
              nameController.clear();
              Navigator.pop(context);
            },
            child: Text(
              "Update User",
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
}
