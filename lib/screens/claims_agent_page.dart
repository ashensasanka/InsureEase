import 'package:app/pages/manage_users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/claim_agent_page.dart';
import '../pages/claim_approve_account.dart';
import '../pages/customer_approve_account.dart';
import '../pages/manage_company.dart';
import '../pages/select_user_type.dart';
import '../pages/update_video_page.dart';
import 'add_video_page.dart';

class ClaimsAgentPage extends StatefulWidget {
  const ClaimsAgentPage({super.key});

  @override
  State<ClaimsAgentPage> createState() => _ClaimsAgentPageState();
}

class _ClaimsAgentPageState extends State<ClaimsAgentPage> {
  @override
  Widget build(BuildContext context) {
    double x = 240;
    double y = 70;
    return Scaffold(
      backgroundColor: Color(0xfff9a130),
      appBar: AppBar(
        title: Text(
          "Hi Agent..",
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
            Container(
              height: y,
              width: x,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClaimAgentPage()), // Replace NextPage with the name of your next page widget
                  );
                },
                child: Text(
                  'Manage Garages',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
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
              height: 28,
            ),
            //Update Package
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
                  'Manage Videos',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
