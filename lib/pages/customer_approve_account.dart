import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/firestore.dart';

class CustomerAppPage extends StatefulWidget {
  const CustomerAppPage({super.key});

  @override
  State<CustomerAppPage> createState() => _CustomerAppPageState();
}

class _CustomerAppPageState extends State<CustomerAppPage> {
  final FireStoreService fireStoreService = FireStoreService();
  String _searchText = '';
  String selectedStatus = 'Pending';
  Widget _buildSearchBar() {
    return TextField(
      onChanged: (value) {
        setState(() {
          _searchText = value;
        });
      },
      decoration: InputDecoration(
        labelText: 'Search',
        hintText: 'Search notes...',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
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
              Text(
                'Change Status',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              DropdownSelection(
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value;
                  });
                },
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              fireStoreService.updateUserStatus(
                docID!,
                selectedStatus,
              );
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Approve Customer Accounts",
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
                        String approval = data['approval'] ?? '';
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
                                      SizedBox(height: 4.0),
                                      Text(
                                        approval,
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
}

class DropdownSelection extends StatefulWidget {
  final Function(String) onChanged;

  const DropdownSelection({required this.onChanged});

  @override
  _DropdownSelectionState createState() => _DropdownSelectionState();
}


class _DropdownSelectionState extends State<DropdownSelection> {
  String selectedValue = 'Pending';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
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
                'Pending',
                'Approved'
              ].map<DropdownMenuItem<String>>(
                    (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text(value),
                    ),
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
