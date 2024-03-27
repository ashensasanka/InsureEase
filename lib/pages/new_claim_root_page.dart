import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/plants.dart';
import '../screens/add_claim.dart';
import '../screens/add_image_page.dart';
import '../screens/home_page.dart';
import '../screens/upload_image.dart';

class NewClaimRootPage extends StatefulWidget {
  const NewClaimRootPage({Key? key}) : super(key: key);

  @override
  State<NewClaimRootPage> createState() => _NewClaimRootPageState();
}

class _NewClaimRootPageState extends State<NewClaimRootPage> {
  List<Plant> favorites = [];
  List<Plant> myCart = [];
  int _bottomNavIndex = 0;

  //List of the pages
  List<Widget> _widgetOptions() {
    return [
      const AddClaim(),
      // UploadImgPage(),
      AddImagePage(),
      // CartPage(addedToCartPlants: myCart,),
      // const ProfilePage(),
    ];
  }

  //List of the pages icons
  List<IconData> iconList = [
    Icons.home,
    Icons.car_crash,
    Icons.shopping_cart,
    Icons.person,
  ];

  //List of the pages titles
  List<String> titleList = [
    'New Claim',
    'Upload Image',
    'Cart',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titleList[_bottomNavIndex],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: IndexedStack(
        index: _bottomNavIndex,
        children: _widgetOptions(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        iconSize: 30,
        backgroundColor: Color(0xff1F36C7),
        splashColor: Colors.black,
        activeColor: Colors.white,
        inactiveColor: Colors.black,
        icons: iconList,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.end,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
            final List<Plant> favoritedPlants = Plant.getFavoritedPlants();
            final List<Plant> addedToCartPlants = Plant.addedToCartPlants();
            favorites = favoritedPlants;
            myCart = addedToCartPlants.toSet().toList();
          });
        },
      ),
    );
  }
}
