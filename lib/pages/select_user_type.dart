import 'package:flutter/material.dart';

import '../auth_pages/user_auth.dart';
import 'admin_login_page.dart';

class SelectUserType extends StatefulWidget {
  const SelectUserType({super.key});

  @override
  State<SelectUserType> createState() => _SelectUserTypeState();
}

class _SelectUserTypeState extends State<SelectUserType> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          color: Color(0xffD9D3D3),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Register to get \nstarted with \nInsureEase',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Text(
                  'Please Select your \nuser type',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(
                  height: 80,
                ),
                //Learner
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserAuthPage(
                          userType: 'customer',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 53,
                    width: 200,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.black12.withOpacity(.2),
                          offset: const Offset(2, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(100),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffF9A130),
                          Color(0xffF9A130),
                        ],
                      ),
                    ),
                    child: Text(
                      'Customer',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.75),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                //Dispatch Partner
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserAuthPage(
                          userType: 'claimsagent',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 53,
                    width: 200,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.black12.withOpacity(.2),
                          offset: const Offset(2, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(100),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffF9A130),
                          Color(0xffF9A130),
                        ],
                      ),
                    ),
                    child: Text(
                      'Claims Agent',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.75),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 110,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminLoginPage()),
                    );
                  },
                  child: Text(
                    'Admin login',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                      decorationThickness: 2.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
