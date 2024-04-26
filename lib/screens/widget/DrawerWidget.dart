import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../pages/select_user_type.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xfff9a130)
              ),
              accountName: Text(
                "Ashen",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                "ashen1@gmail.com",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/propic.png"),
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
              CupertinoIcons.heart_fill,
              color: Colors.red,
            ),
            title: Text(
              "My Wish List",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Navigate to My Wish List Page
              Navigator.pop(context); // Close Drawer
              Navigator.pushNamed(context, '/my_wish_list');
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
            onTap: () async{
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
