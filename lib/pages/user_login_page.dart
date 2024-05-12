import 'dart:convert';
import 'package:app/pages/user_register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'admin_login_page.dart';

class UserLoginPage extends StatefulWidget {
  final Function()? onTop;
  final String userType;
  const UserLoginPage({super.key, this.onTop, required this.userType});

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  void wrongEmailMessage() {
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Incorrect Email or Password'),
          );
        },
      );
    }
  }

  void signUserIn() async {
    if (mounted) {
      // Show loading circle
      showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: pass.text,
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'invalid-credential') {
        wrongEmailMessage();
      }
    }
  }

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Image.asset('assets/images/logo2.png'),
                Text(
                  ' Insurease',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 150,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 200, 0),
                  child: Text(
                    "Username",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                    controller: email,
                    style: const TextStyle(color: Colors.black, fontSize: 17),
                    decoration: InputDecoration(
                      prefixIconConstraints: const BoxConstraints(minWidth: 45),
                      hintStyle:
                          const TextStyle(color: Colors.black, fontSize: 14.5),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 4),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 200, 0),
                  child: Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30)
                      .copyWith(bottom: 10),
                  child: TextField(
                    controller: pass,
                    style: const TextStyle(color: Colors.black, fontSize: 14.5),
                    obscureText: isPasswordVisible ? false : true,
                    decoration: InputDecoration(
                      prefixIconConstraints: const BoxConstraints(minWidth: 45),
                      suffixIconConstraints:
                          const BoxConstraints(minWidth: 45, maxWidth: 46),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        child: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                          size: 22,
                        ),
                      ),
                      border: InputBorder.none,
                      hintStyle:
                          const TextStyle(color: Colors.black, fontSize: 14.5),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 4),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    signUserIn();
                  },
                  child: Container(
                    height: 53,
                    width: 250,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.black12.withOpacity(.2),
                          offset: const Offset(2, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New User?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserRegiterPage(
                              userType: widget.userType,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Join Us',
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Forgot your Password?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return ForgotPasswordPage();
                        //     },
                        //   ),
                        // );
                      },
                      child: Text(
                        'Reset',
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
