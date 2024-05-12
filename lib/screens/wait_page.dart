import 'package:flutter/material.dart';

class WaitAdminApprove extends StatefulWidget {
  const WaitAdminApprove({super.key});

  @override
  State<WaitAdminApprove> createState() => _WaitAdminApproveState();
}

class _WaitAdminApproveState extends State<WaitAdminApprove> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffef6eb),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xfffef6eb),
        title: Text(
          'Account Approval',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 125,),
          Center(
            child: Icon(
              Icons.check_circle_outline,
              size: 150,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 40,),
          Center(
            child: Text(
              'Account Create successful.\n Thank you for continuing with \nour service',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Center(
            child: Text(
                'Wait for Admin Approval !',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(height: 70,),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Return to Home screen',
              style: TextStyle(color: Colors.black),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFF9A130),
              side: BorderSide(color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}
