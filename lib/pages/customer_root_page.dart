import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:app/pages/payment_options.dart';
import 'package:app/pages/suppliers_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../constants.dart';
import '../models/plants.dart';
import '../screens/chat_page.dart';
import '../screens/home_page.dart';
import 'new_claim_root_page.dart';

class CustomerRootPage extends StatefulWidget {
  const CustomerRootPage({Key? key}) : super(key: key);

  @override
  State<CustomerRootPage> createState() => _CustomerRootPageState();
}

class _CustomerRootPageState extends State<CustomerRootPage> {
  List<Plant> favorites = [];
  List<Plant> myCart = [];
  int _bottomNavIndex = 0;

  //List of the pages
  List<Widget> _widgetOptions() {
    return [
      const HomePage(),
      const ChatPage(),
      const SuppliersPage(),
      const PaymentOption()
    ];
  }

  //List of the pages icons
  List<IconData> iconList = [
    Icons.home,
    Icons.chat,
    Icons.person_pin_circle_outlined,
    Icons.payments,
  ];

  //List of the pages titles
  List<String> titleList = [
    'Home',
    'Ask the Bot',
    'Roadside Assistance',
    'Payment Options',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 10,),
            Text(
              titleList[_bottomNavIndex],
              style: TextStyle(
                color: Constants.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
            Icon(
              Icons.notifications,
              color: Constants.blackColor,
              size: 30.0,
            )
          ],
        ),
        backgroundColor: Color(0xffF5F5F5),
      ),
      body: IndexedStack(
        index: _bottomNavIndex,
        children: _widgetOptions(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, PageTransition(
              child: const NewClaimRootPage(), type: PageTransitionType.bottomToTop)
          );
        },
        child: Icon(Icons.add,size: 37,),
        backgroundColor: Constants.primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: Color(0xfffef6eb),
        splashColor: Constants.primaryColor,
        activeColor: Constants.primaryColor,
        inactiveColor: Colors.black.withOpacity(.5),
        icons: iconList,
        iconSize: 30,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) {
          setState(
            () {
              _bottomNavIndex = index;
              final List<Plant> favoritedPlants = Plant.getFavoritedPlants();
              final List<Plant> addedToCartPlants = Plant.addedToCartPlants();

              favorites = favoritedPlants;
              myCart = addedToCartPlants.toSet().toList();
            },
          );
        },
      ),
    );
  }
}
