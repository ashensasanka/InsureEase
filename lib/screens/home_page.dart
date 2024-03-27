import 'package:app/screens/add_claim.dart';
import 'package:app/screens/widget/AppBarWidget.dart';
import 'package:app/screens/widget/DrawerWidget.dart';
import 'package:app/screens/widget/plant_widget.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../constants.dart';
import '../models/plants.dart';
import '../pages/new_claim_root_page.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    Size size = MediaQuery.of(context).size;

    List<Plant> _plantList = Plant.plantList;

    //Plants category
    List<String> _plantTypes = [
      'Your Insured Cars',
    ];

    return Scaffold(
      body: SingleChildScrollView(
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
                    itemCount: _plantTypes.length,
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
                            _plantTypes[index],
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: selectedIndex == index
                                    ? FontWeight.bold
                                    : FontWeight.w300,
                                color: Colors.black),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * .25,
              child: ListView.builder(
                itemCount: _plantList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      if (_plantList[index].isAdd) {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: NewClaimRootPage(),
                            type: PageTransitionType.bottomToTop,
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: DetailPage(
                              plantId: _plantList[index].plantId,
                            ),
                            type: PageTransitionType.bottomToTop,
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: 190,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 50,
                            right: 50,
                            top: 50,
                            bottom: 50,
                            child: Image.asset(
                              _plantList[index].imageURL,
                            ),
                          ),
                          Positioned(
                            bottom: 15,
                            left: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _plantList[index].category,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  _plantList[index].plantName,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _plantList[index].isAdd
                              ? Positioned(
                                  bottom: 40,
                                  right: 20,
                                  child: Text(
                                    'Add New Claim',
                                    style: TextStyle(
                                        color: Color(
                                          0xfff9a130,
                                        ),
                                        fontSize: 20),
                                  ),
                                )
                              : Positioned(
                                  bottom: 15,
                                  right: 20,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(
                                        0xfffef6eb,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ),
                                    ),
                                    child: Text(
                                      _plantList[index].price.toString() +
                                          r' Claim',
                                      style: TextStyle(
                                        color: Color(0xfff9a130),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: _plantList[index].isAdd
                            ? Color(0xfffef6eb)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16, bottom: 20, top: 20),
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
              height: size.height * .5,
              child: ListView.builder(
                itemCount: _plantList.length,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            child:
                                DetailPage(plantId: _plantList[index].plantId),
                            type: PageTransitionType.bottomToTop),
                      );
                    },
                    child: PlantWidget(index: index, plantList: _plantList),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      drawer: DrawerWidget(),
    );
  }
}
