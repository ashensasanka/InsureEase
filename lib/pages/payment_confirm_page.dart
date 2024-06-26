import 'package:flutter/material.dart';

class PaymentConfirmPage extends StatefulWidget {
  const PaymentConfirmPage({Key? key}) : super(key: key);

  @override
  State<PaymentConfirmPage> createState() => _PaymentConfirmPageState();
}

class _PaymentConfirmPageState extends State<PaymentConfirmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffef6eb),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffF9A130),
        title: Text(
          'Your Coverage has been reinstalled',
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
              'Payment successful.\n Thank you for continuing with \nour service',
              textAlign: TextAlign.center,
              style: TextStyle(
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
              'Return to payment screen',
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
