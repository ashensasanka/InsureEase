import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../controller/firestore.dart';
import '../../pages/select_user_type.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final User? user = FirebaseAuth.instance.currentUser;

class DrawerWidget extends StatefulWidget {
  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  File? _image;
  final FireStoreService fireStoreService = FireStoreService();

  Future<void> _getImageFromGallery() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
  void openNoteBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap:  _getImageFromGallery,
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
              fireStoreService.addProPic(
                  user?.uid,
                  _image,
                  'image'
              );
              Fluttertoast.showToast(
                msg: "Note added successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.green,
                textColor: Colors.white,
              );

              Navigator.pop(context);
            },
            child: Text("Add Image"),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color(0xfff9a130)),
              accountName: StreamBuilder<DocumentSnapshot>(
                stream: _firestore
                    .collection('login_users')
                    .doc(user?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  final DocumentSnapshot document = snapshot.data!;
                  final Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  return Text(
                    '${data['name']}',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              accountEmail: StreamBuilder<DocumentSnapshot>(
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
                  return Text('${data['email']}',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),);
                },
              ),
              currentAccountPicture: GestureDetector(
                onTap: openNoteBox,
                child: StreamBuilder<DocumentSnapshot>(
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
                    return data['imageUrl'] == null? CircleAvatar(
                      backgroundImage: AssetImage("assets/propic.png"),
                    ):CircleAvatar(
                      backgroundImage: NetworkImage("${data['imageUrl']}"),
                    );
                  },
                ),
              ),
            ),
          ),
          // Home
          ListTile(
            leading: Icon(
              CupertinoIcons.home,
              color: Colors.red,
            ),
            title: Text(
              "Home",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Navigate to Home Page
              Navigator.pop(context); // Close Drawer
              Navigator.pushNamed(context, '/homePage');
            },
          ),

          // My Account
          ListTile(
            leading: Icon(
              CupertinoIcons.person,
              color: Colors.red,
            ),
            title: Text(
              "Quizzes",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Navigate to My Account Page
              Navigator.pop(context); // Close Drawer
              Navigator.pushNamed(context, '/quizes');
            },
          ),

          // My Orders
          ListTile(
            leading: Icon(
              CupertinoIcons.play_circle,
              color: Colors.red,
            ),
            title: Text(
              "Video Tutorials",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Navigate to My Orders Page
              Navigator.pop(context); // Close Drawer
              Navigator.pushNamed(context, '/videos');
            },
          ),

          // My Wish List
          ListTile(
            leading: Icon(
              CupertinoIcons.person_2_alt,
              color: Colors.red,
            ),
            title: Text(
              "Community",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Navigate to My Wish List Page
              Navigator.pop(context); // Close Drawer
              Navigator.pushNamed(context, '/community');
            },
          ),

          // Settings
          ListTile(
            leading: Icon(
              CupertinoIcons.settings,
              color: Colors.red,
            ),
            title: Text(
              "Settings",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Navigate to Settings Page
              Navigator.pop(context); // Close Drawer
              Navigator.pushNamed(context, '/settings');
            },
          ),

          // Log Out
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            title: Text(
              "Log Out",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () async {
              // Sign out the current user
              try {
                await FirebaseAuth.instance.signOut();
                // Navigate to the login screen or home screen after sign out
                // Example:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectUserType(),
                  ),
                );
              } catch (e) {
                print('Error signing out: $e');
                // Handle signout error
              }
            },
          ),
        ],
      ),
    );
  }
}
