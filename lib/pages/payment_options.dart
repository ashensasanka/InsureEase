import 'package:app/pages/paymentdetails_page.dart';
import 'package:flutter/material.dart';

class PaymentOption extends StatefulWidget {
  const PaymentOption({super.key});

  @override
  State<PaymentOption> createState() => _PaymentOptionState();
}

class _PaymentOptionState extends State<PaymentOption> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(45, 10, 10, 10),
                child: Container(
                  width: 90,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        10), // Adjust the radius as needed
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Image.asset('assets/Vector.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Container(
                  width: 90,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Image.asset('assets/image2.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Container(
                  width: 90,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        10), // Adjust the radius as needed
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Image.asset('assets/image1.png'),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(70, 10, 0, 0),
            child: Row(
              children: [
                Text(
                  'Insurance Premium',
                  style: TextStyle(
                    fontSize: 17,
                    color: Color(0xff0A397E),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(90, 0, 0, 0),
                  child: Text(
                    '\$50',
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xff0A397E),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(70, 10, 0, 0),
            child: Row(
              children: [
                Text(
                  'Value Added Taxes',
                  style: TextStyle(
                    fontSize: 17,
                    color: Color(0xff0A397E),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
                  child: Text(
                    '\$5',
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xff0A397E),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 3,
            endIndent: 40,
            indent: 60,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(70, 0, 0, 0),
            child: Row(
              children: [
                Text(
                  'Total amount',
                  style: TextStyle(
                    fontSize: 17,
                    color: Color(0xff0A397E),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(130, 0, 0, 0),
                  child: Text(
                    '\$65',
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xff0A397E),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(),
                  ),
                );
              },
              child: Container(
                width: 160,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffF9A130),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                    child: Text(
                  'CONTINUE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
