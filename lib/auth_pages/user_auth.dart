import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login_register_page/user_loginorregister_page.dart';
import '../pages/root_page.dart';

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
                    if (userRole == 'customer') {
                      return RootPage();
                      // return const DashBoard();
                    } else if (userRole == 'vendor') {
                      return const CircularProgressIndicator();
                      // return const DashBoardVendor();
                      // return VerifyEmailPage();
                    } else {
                      return const CircularProgressIndicator();
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
