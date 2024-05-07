import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/claims.dart';
import '../models/plants.dart';

class DetailPage extends StatefulWidget {
  final int claimIndex;
  const DetailPage({Key? key, required this.claimIndex}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<Claims> claimsList = [];

  @override
  void initState() {
    super.initState();
    fetchClaims(); // Call the method to fetch claims when the widget initializes
  }

  // Method to fetch claims from Firestore
  void fetchClaims() async {
    List<Claims> claims = await Claims.getClaimsFromFirestore();
    setState(() {
      claimsList = claims; // Update the state with retrieved claims
    });
  }

  //Toggle Favorite button
  bool toggleIsFavorated(bool isFavorited) {
    return !isFavorited;
  }

  //Toggle add remove from cart
  bool toggleIsSelected(bool isSelected) {
    return !isSelected;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 100,
            left: 50,
            child: Text(
              'Claim Description',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Positioned(
            bottom: 290,
            left: 0,
            right: 0,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
                  height: size.height * .4,
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
                        claimsList[widget.claimIndex].claimId,
                        style: TextStyle(
                          color: Constants.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                claimsList[widget.claimIndex].typeofAccident,
                                style: TextStyle(
                                  color: Constants.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                              Text(
                                claimsList[widget.claimIndex].typeofIncident,
                                style: TextStyle(
                                  color: Constants.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                claimsList[widget.claimIndex].vehicle,
                                style: TextStyle(
                                  color: Constants.blackColor,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                claimsList[widget.claimIndex].model,
                                style: TextStyle(
                                  color: Constants.blackColor,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                claimsList[widget.claimIndex]
                                    .registrationNumber
                                    .toInt()
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 30.0,
                                  color: Constants.primaryColor,
                                ),
                              ),
                              Text(
                                claimsList[widget.claimIndex].year,
                                style: TextStyle(
                                  fontSize: 30.0,
                                  color: Constants.primaryColor,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                claimsList[widget.claimIndex].insuraceType,
                                style: TextStyle(
                                  color: Constants.blackColor,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Expire Date: ${claimsList[widget.claimIndex].expiryDate}',
                                style: TextStyle(
                                  color: Constants.blackColor,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 220,
            left: 50,
            right: 0,
            child: Text(
              'Claim Status',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          Positioned(
            bottom: 160,
            left: 30,
            right: 0,
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xffF9A130),
                    borderRadius: BorderRadius.circular(
                        10), // Adjust the radius as needed
                  ),
                  child: Center(
                    child: Text(
                      'Approved',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xff828282),
                    borderRadius: BorderRadius.circular(
                        10), // Adjust the radius as needed
                  ),
                  child: Center(
                    child: Text(
                      'On-hold',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xff828282),
                    borderRadius: BorderRadius.circular(
                        10), // Adjust the radius as needed
                  ),
                  child: Center(
                    child: Text(
                      'Not approved',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 100,
            bottom: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 200,
                    height: 33,
                    decoration: BoxDecoration(
                      color: Color(0xffF9A130),
                      borderRadius: BorderRadius.circular(
                          10), // Adjust the radius as needed
                    ),
                    child: Center(
                      child: Text(
                        'Return to Home screen',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlantFeature extends StatelessWidget {
  final String plantFeature;
  final String title;
  const PlantFeature({
    Key? key,
    required this.plantFeature,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Constants.blackColor,
          ),
        ),
        Text(
          plantFeature,
          style: TextStyle(
            color: Constants.primaryColor,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
