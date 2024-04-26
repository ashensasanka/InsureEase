import 'package:app/pages/manage_users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/claim_approve_account.dart';
import '../pages/customer_approve_account.dart';
import '../pages/manage_company.dart';
import '../pages/select_user_type.dart';
import '../pages/update_video_page.dart';
import 'add_video_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    double x = 230;
    double y = 40;
    return Scaffold(
      backgroundColor: Color(0xfff9a130),
      appBar: AppBar(
        title: Text(
          "InsureEase",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut();
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
            icon: Icon(Icons.logout,size: 30,),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Shop
            Text(
              'Manage users',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 5),
            //Add Package
            Container(
              height: y,
              width: x,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ManageUsersPage()), // Replace NextPage with the name of your next page widget
                  );
                },
                child: Text(
                  'Manage customer details',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            //Update Package
            Container(
              height: y,
              width: x,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ManageCompanyPage()), // Replace NextPage with the name of your next page widget
                  );
                },
                child: Text(
                  'Manage company details',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
            ),
            Divider(
              thickness: 2,
              endIndent: 30,
              indent: 30,
              color: Colors.black,
            ),
            //Learning Material
            Text(
              'Learning Material',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 10),
            //Add video
            Container(
              height: y,
              width: x,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddVideoPage()), // Replace NextPage with the name of your next page widget
                  );
                },
                child: Text(
                  'Add video',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.black),
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            //Update video
            Container(
              height: y,
              width: x,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UpdateVideoPage()), // Replace NextPage with the name of your next page widget
                  );
                },
                child: Text(
                  'Update video',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.black),
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            //Delete video
            Divider(
              thickness: 2,
              endIndent: 30,
              indent: 30,
              color: Colors.black,
            ),
            //Approve Account
            Text(
              'Approve Account',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 10),
            //Add video
            Container(
              height: y,
              width: x,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CustomerAppPage()), // Replace NextPage with the name of your next page widget
                  );
                },
                child: Text(
                  'Customer',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.black),
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            //Update video
            Container(
              height: y,
              width: x,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClaimAppPage()), // Replace NextPage with the name of your next page widget
                  );
                },
                child: Text(
                  'Claims Agent',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.black),
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
            ),
            Divider(
              thickness: 2,
              endIndent: 30,
              indent: 30,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
