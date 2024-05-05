import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/firestore.dart';
import 'forum_page.dart';

class ViewPage extends StatefulWidget {
  final String message;
  final String docID;
  const ViewPage({Key? key, required this.message, required this.docID}) : super(key: key);

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final messageCollection = FirebaseFirestore.instance.collection("replay_message");
  final User? user = FirebaseAuth.instance.currentUser;
  final FireStoreService fireStoreService = FireStoreService();

  void editMessage(int index, String field) async {
    String newValue = '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          "View Message",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          controller: TextEditingController(text: newValue),
          decoration: InputDecoration(
            hintText: "Enter new message",
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context, newValue); // Pop with newValue as result
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ).then((value) async { // Wait for dialog result
      if (value != null && value.trim().isNotEmpty) {
        await messageCollection.doc(field).update({'message': value});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffDADADA),
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
          child: Text('Community Forum'),
        ),
      ),
      body: Container(
        color: Color(0xffDADADA),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 5, 10),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ), // Add your icon here
                label: Text(
                  'Back to all question',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffF9A130), // Change button color to black
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(14, 0, 5, 10),
              child: Container(
                width: 370,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(
                    10,
                  ), // Adjust the radius as needed
                ), // Gray background color for sent messages
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 280,
                          height: 70,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 5, 5, 0),
                            child: Text(widget.message,style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _confirmDelete(context, widget.docID);
                          },
                          child: Text('Delete',style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Row(
                        children: [
                          StreamBuilder<DocumentSnapshot>(
                            stream: _firestore.collection('login_users').doc(user?.uid).snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              }
                              if (snapshot.hasError) {
                                return Center(child: Text('Error: ${snapshot.error}'));
                              }
                              final DocumentSnapshot document = snapshot.data!;
                              final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                              return Text('${data['name']}',style: TextStyle(color: Colors.white));
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text('${DateTime.now().toString().split(' ')[0]}',style: TextStyle(color: Colors.white)),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: _firestore.collection('replay_message${widget.message}').snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                }
                                if (snapshot.hasError) {
                                  return Center(child: Text('Error: ${snapshot.error}'));
                                }
                                return Text('${snapshot.data!.size} answers',style: TextStyle(color: Colors.white));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('replay_message${widget.message}').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  final List<DocumentSnapshot> documents1 = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: documents1.length,
                    itemBuilder: (context, index) {
                      final message = documents1[index]['message'];
                      final owner = documents1[index]['email'];
                      final Timestamp timestamp = documents1[index]['timestamp'];
                      final DateTime dateTime = timestamp.toDate();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 100,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ), // Adjust the radius as needed
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.person_pin,
                                        size: 50, // Adjust the size of the icon as needed
                                        color: Colors.black, // Adjust the color of the icon as needed
                                      ),
                                      StreamBuilder<DocumentSnapshot>(
                                        stream: _firestore.collection('learner_users').doc(owner).snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Center(child: CircularProgressIndicator());
                                          }
                                          if (snapshot.hasError) {
                                            return Center(child: Text('Error: ${snapshot.error}'));
                                          }
                                          final DocumentSnapshot document = snapshot.data!;
                                          final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                                          return Text('${data['name']}');
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: 280,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ), // Adjust the radius as needed
                                ), // Gray background color for sent messages
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 200,
                                          height: 70,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(20, 10, 5, 0),
                                            child: Text(message),
                                          ),
                                        ),
                                        // TextButton(
                                        //   onPressed: () => editMessage(index,message),
                                        //   child: Text('Edit'),
                                        // ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Row(
                                        children: [
                                          StreamBuilder<DocumentSnapshot>(
                                            stream: _firestore.collection('learner_users').doc(owner).snapshots(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                return Center(child: CircularProgressIndicator());
                                              }
                                              if (snapshot.hasError) {
                                                return Center(child: Text('Error: ${snapshot.error}'));
                                              }
                                              final DocumentSnapshot document = snapshot.data!;
                                              final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                                              return Text('${data['name']}');
                                            },
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(dateTime.toString().split(' ')[0]),
                                          SizedBox(
                                            width: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      );
                    },
                  );
                },
            ),
            ),
            Divider(
              thickness: 2,
              indent: 20,
              endIndent: 20,
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
                Text('Are you sure you want to delete this note?'),
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
                fireStoreService.deleteNote(docID);
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
