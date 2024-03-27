import 'dart:convert';
import 'package:app/auth_pages/user_auth.dart';
import 'package:app/pages/user_login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'admin_login_page.dart';

class AdminRegiterPage extends StatefulWidget {
  const AdminRegiterPage({super.key});

  @override
  State<AdminRegiterPage> createState() => _AdminRegiterPageState();
}

class _AdminRegiterPageState extends State<AdminRegiterPage> {
  TextEditingController name = TextEditingController();
  TextEditingController emailctrl = TextEditingController();
  TextEditingController pass = TextEditingController();

  postDetailsToFirestore() async {
    var user = FirebaseAuth.instance.currentUser;
    CollectionReference user_register = FirebaseFirestore.instance.collection('login_users');
    user_register.doc(user?.uid).set({
      'email':emailctrl.text,
      'name':name.text,
      'password':pass.text,
      'address':'',
      'contact':'',
      'city':'',
      'cardholder_name':'',
      'card_number':'',
      'expire_date':'',
      'roal':'admin'
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => UserAuthPage(userType: 'admin',)));
  }

  // sign user up method
  void signUserUp() async {
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    // try creating the user
    try {
      // check if password is confirmed
        FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailctrl.text,
          password: pass.text,
        ).then((value) => {postDetailsToFirestore()}).catchError((e){});

      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // show error message
      showErrorMesaage(e.code);
    }
  }

  // error message to user
  void showErrorMesaage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.blueGrey,
            title: Center(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                )),
          );
        });
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
                image: AssetImage('assets/registerback.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Text('Register to get \nstarted with \nInsureEase!',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold
                  ),),
                  const SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 200, 0),
                    child: Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                      controller: name,
                      style: const TextStyle(color: Colors.black, fontSize: 17),
                      decoration: InputDecoration(
                        prefixIconConstraints: const BoxConstraints(minWidth: 45),
                        hintStyle:
                        const TextStyle(color: Colors.black, fontSize: 14.5),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black,
                              width: 4),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                              Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 160, 0),
                    child: Text(
                      "Admin ID",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                      controller: emailctrl,
                      style: const TextStyle(color: Colors.black, fontSize: 17),
                      decoration: InputDecoration(
                        prefixIconConstraints: const BoxConstraints(minWidth: 45),
                        hintStyle:
                        const TextStyle(color: Colors.black, fontSize: 14.5),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black,
                              width: 4),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                              Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 150, 0),
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
                          borderSide: BorderSide(
                              color: Colors.black,
                              width: 4),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                              Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      signUserUp();
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
                                offset: const Offset(2, 2))
                          ],
                          borderRadius: BorderRadius.circular(100),
                          ),
                      child: Text('Register',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already Have Account?',
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
                              builder: (context) => AdminLoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                            decorationThickness: 2.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
