import 'package:app/screens/add_claim.dart';
import 'package:app/screens/widget/AppBarWidget.dart';
import 'package:app/screens/widget/DrawerWidget.dart';
import 'package:app/screens/widget/claim_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../constants.dart';
import '../models/claims.dart';
import '../models/plants.dart';
import '../pages/new_claim_root_page.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Claims> claimsList = [];
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    fetchClaims(); // Call the method to fetch claims when the widget initializes
  }

  // Method to fetch claims from Firestore
  void fetchClaims() async {
    List<Claims> claims = await Claims.getClaimsFromFirestore();
    setState(
      () {
        claimsList = claims; // Update the state with retrieved claims
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    Size size = MediaQuery.of(context).size;

    List<Plant> plantList = Plant.plantList;

    //Plants category
    List<String> plantTypes = [
      'Your Insured Cars',
    ];

    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: RefreshIndicator(
        onRefresh: () async {
          fetchClaims();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppBarWidget(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    height: 50.0,
                    width: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: plantTypes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(
                                () {
                                  selectedIndex = index;
                                },
                              );
                            },
                            child: Text(
                              plantTypes[index],
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: selectedIndex == index
                                    ? FontWeight.bold
                                    : FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * .17,
                child: ListView.builder(
                  itemCount: plantList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        // if (plantList[index].isAdd) {
                        //   Navigator.push(
                        //     context,
                        //     PageTransition(
                        //       child: const NewClaimRootPage(),
                        //       type: PageTransitionType.bottomToTop,
                        //     ),
                        //   );
                        // } else {

                        Navigator.push(
                          context,
                          PageTransition(
                            child: DetailPage(
                              claimIndex: plantList[index].plantId,
                            ),
                            type: PageTransitionType.bottomToTop,
                          ),
                        );
                        // }
                      },
                      child: Container(
                        width: 200,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color:
                              // plantList[index].isAdd
                              //     ?
                              // const Color(0xfffef6eb),
                              Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 50,
                              right: 50,
                              bottom: 70,
                              child: Image.asset(
                                plantList[index].imageURL,
                              ),
                            ),
                            Positioned(
                              bottom: 15,
                              left: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    plantList[index].category,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    plantList[index].plantName,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // plantList[index].isAdd
                            //     ? const Positioned(
                            //         bottom: 40,
                            //         right: 20,
                            //         child: Text(
                            //           'Add New Claim',
                            //           style: TextStyle(
                            //             color: Color(
                            //               0xfff9a130,
                            //             ),
                            //             fontSize: 20,
                            //           ),
                            //         ),
                            //       )
                            //     :
                            Positioned(
                              bottom: 15,
                              right: 20,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xfffef6eb,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ),
                                ),
                                child: Text(
                                  plantList[index].price.toString() + r' Claim',
                                  style: const TextStyle(
                                    color: Color(0xfff9a130),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 16, bottom: 1, top: 15),
                child: const Text(
                  'Recent Claims',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: size.height * .265,
                child: ListView.builder(
                  itemCount: claimsList.length,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: DetailPage(
                              claimIndex: claimsList[index].claimIndex,
                            ),
                            type: PageTransitionType.bottomToTop,
                          ),
                        );
                      },
                      child: ClaimWidget(index: index, claimList: claimsList),
                    );
                  },
                ),
              ),
              SizedBox(height: 30,),
              Container(
                height: 120,
                child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('login_users')
                      .doc(user?.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    final DocumentSnapshot document = snapshot.data!;
                    final Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    double premium = data['insurancePremium'];
                    double taxes = data['taxes'];
                    double total = premium + taxes;
                    return Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 55, 5),
                              child: Text(
                                'Insurance Premium',
                                style: TextStyle(
                                  color: Color(0xff0A397E),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width: 120,
                              child: Text(
                                'Rs: $premium',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Color(0xff0A397E),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 60, 5),
                              child: Text(
                                'Value Added Taxes',
                                style: TextStyle(
                                  color: Color(0xff0A397E),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width:120,
                              child: Text(
                                'Rs: $taxes',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Color(0xff0A397E),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 3.5,
                          indent: 20,
                          endIndent: 20,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 114, 5),
                              child: Text(
                                'Total amount',
                                style: TextStyle(
                                  color: Color(0xff0A397E),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width:120,
                              child: Text(
                                'Rs: $total',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Color(0xff0A397E),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      drawer: DrawerWidget(),
    );
  }
}
