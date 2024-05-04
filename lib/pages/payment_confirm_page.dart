import 'package:flutter/material.dart';

class OrderPlacePage extends StatefulWidget {
  const OrderPlacePage({Key? key}) : super(key: key);

  @override
  State<OrderPlacePage> createState() => _OrderPlacePageState();
}

class _OrderPlacePageState extends State<OrderPlacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffEEEEEE),
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
