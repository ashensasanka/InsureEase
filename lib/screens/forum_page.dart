import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({Key? key}) : super(key: key);

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final messageCollection = FirebaseFirestore.instance.collection("replay_message");
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community Forum'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('community').snapshots(),
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
                    DocumentSnapshot document = documents1[index];
                    String docID = document.id;
                    final message = documents1[index]['message'];
                    final uid = documents1[index]['uid'];
                    final owner = documents1[index]['email'];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 280,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 280,
                                    height: 70,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(15, 10, 5, 0),
                                      child: Text(
                                        message,
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: StreamBuilder<DocumentSnapshot>(
                                      stream: _firestore.collection('login_users').doc(uid).snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return Center(child: CircularProgressIndicator());
                                        }
                                        if (snapshot.hasError) {
                                          return Center(child: Text('Error: ${snapshot.error}'));
                                        }
                                        final DocumentSnapshot document = snapshot.data!;
                                        final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                                        return Padding(
                                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                          child: Row(
                                            children: [
                                              Text('${data['name']}'),
                                              SizedBox(width: 10),
                                              Text('${DateTime.now().toString().split(' ')[0]}'),
                                              SizedBox(width: 20),
                                              Expanded(
                                                child: StreamBuilder<QuerySnapshot>(
                                                  stream: _firestore.collection('replay_message${message}').snapshots(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                                      return Center(child: CircularProgressIndicator());
                                                    }
                                                    if (snapshot.hasError) {
                                                      return Center(child: Text('Error: ${snapshot.error}'));
                                                    }
                                                    return Text('${snapshot.data!.size} answers');
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: 100,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                                child: TextButton(
                                  onPressed: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => user?.uid == uid? ViewPage(message: message, owner:owner, docID:docID):ReplayPage(message: message,owner: owner),
                                    //   ),
                                    // );
                                    print('Reply to message: $message');
                                  },
                                  child: user?.uid == uid? Text('View'):Text('Replay'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final message = _messageController.text;
                    if (message.isNotEmpty) {
                      _firestore.collection('community').add({
                        'message': message,
                        'uid':user?.uid,
                        'email':user?.email,
                        'timestamp': Timestamp.now(),
                      });
                      _messageController.clear();
                    }
                  },
                  child: Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
