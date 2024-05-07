import 'package:app/pages/select_user_type.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'onboarding_screen.dart';


class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffD9D3D3),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Color(0xffD9D3D3)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                const SizedBox(
                  height: 20,
                ),
                createPage(
                  image: 'assets/images/logo.png',
                  title: Constants.titleOne,
                  description: Constants.descriptionOne,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SelectUserType()),
                    );
                  },
                  child: Container(
                    height: 53,
                    width: 210,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4,
                              color: Colors.green.withOpacity(.2),
                              offset: const Offset(2, 2))
                        ],
                        borderRadius: BorderRadius.circular(100),
                        ),
                    child: Text('Start Here',
                        style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
