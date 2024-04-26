import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/claims.dart';
import '../models/plants.dart';
import '../models/suppliers.dart';

class SupplierDetailPage extends StatefulWidget {
  final int supplierIndex;
  const SupplierDetailPage({Key? key, required this.supplierIndex}) : super(key: key);

  @override
  State<SupplierDetailPage> createState() => _SupplierDetailPageState();
}

class _SupplierDetailPageState extends State<SupplierDetailPage> {
  List<Claims> claimsList = [];
  List<Suppliers> suppliersList = [];

  @override
  void initState() {
    super.initState();
    fetchClaims(); // Call the method to fetch claims when the widget initializes
    fetchSuppliers();
  }

  // Method to fetch claims from Firestore
  void fetchClaims() async {
    List<Claims> claims = await Claims.getClaimsFromFirestore();
    setState(() {
      claimsList = claims; // Update the state with retrieved claims
    });
  }

  void fetchSuppliers() async {
    List<Suppliers> suppliers = await Suppliers.getSuppliersFromFirestore();
    setState(() {
      suppliersList = suppliers; // Update the state with retrieved claims
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          //Close icon
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color(0xfffef6eb),
                    ),
                    child: Icon(
                      Icons.close,
                      color: Color(0xfff9a130),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //Image
          Positioned(
            top: 100,
            left: 20 ,
            right: 20,
            child: Container(
              width: size.width * .8,
              height: size.height * .8,
              padding: const EdgeInsets.all(10),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          20), // Set the border radius to make it rounded
                      child: SizedBox(
                        height: 270,
                        width: 330,
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/insureease-1c252.appspot.com/o/supplier%2Fitem1712598507930?alt=media&token=461d7c07-5b77-4a96-b683-c007d94c915f',
                          // claimsList[widget.supplierIndex].imageURL,
                          fit: BoxFit
                              .cover, // Optionally, set the fit property to cover the entire widget
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
              height: size.height * .5,
              width: size.width,
              decoration: BoxDecoration(
                color: Color(0xfffef6eb),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    suppliersList[widget.supplierIndex].supplierId,
                    style: TextStyle(
                      color: Constants.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            suppliersList[widget.supplierIndex].supplierName,
                            style: TextStyle(
                              color: Constants.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
