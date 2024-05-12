import 'package:app/pages/lets_start_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login_register_page/user_loginorregister_page.dart';
import '../pages/agent_root_page.dart';
import '../pages/claim_agent_page.dart';
import '../pages/customer_root_page.dart';
import '../screens/admin_page.dart';
import '../screens/wait_page.dart';

class UserAuthPage extends StatefulWidget {
  final String userType;
  UserAuthPage({Key? key, required this.userType});

  @override
  State<UserAuthPage> createState() => _UserAuthPageState();
}

class _UserAuthPageState extends State<UserAuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is logged in
          if (snapshot.hasData) {
            User? user = snapshot.data;
            if (user != null) {
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance.collection('login_users').doc(user.uid).get(),
                builder: (context, documentSnapshot) {
                  if (documentSnapshot.hasData && documentSnapshot.data != null) {
                    String userRole = documentSnapshot.data!.get('roal');
                    if (userRole == 'customer' ) {
                      String userStatus = documentSnapshot.data!.get('approval');
                      if (userStatus == 'Approved'){
                        return CustomerRootPage();
                      } else {
                        return WaitAdminApprove();
                      }
                      // return const DashBoard();
                    } else if (userRole == 'admin'){
                      return const AdminPage();
                    }
                    else {
                      return const AgentRootPage();
                      // return const DashBoardDisp();
                    }
                  } else {
                    return const CircularProgressIndicator(); // Handle loading state
                  }
                },
              );
            }
          }
          // User is not logged in
          return UserLoginOrRegisterPage(userType: widget.userType);
        },
      ),
    );
  }
}
