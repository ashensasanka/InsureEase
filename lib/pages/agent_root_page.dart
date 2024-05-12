import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:app/pages/select_user_type.dart';
import 'package:app/pages/update_premium_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/plants.dart';
import '../screens/add_claim.dart';
import '../screens/add_image_page.dart';
import '../screens/add_video_page.dart';
import '../screens/home_page.dart';
import '../screens/upload_image.dart';
import 'claim_agent_page.dart';

class AgentRootPage extends StatefulWidget {
  const AgentRootPage({Key? key}) : super(key: key);

  @override
  State<AgentRootPage> createState() => _AgentRootPageState();
}

class _AgentRootPageState extends State<AgentRootPage> {
  List<Plant> favorites = [];
  List<Plant> myCart = [];
  int _bottomNavIndex = 0;
  String docName = '${DateTime.now().millisecondsSinceEpoch}';

  //List of the pages
  List<Widget> _widgetOptions() {
    return [ClaimAgentPage(), AddVideoPage(), UpdatePremiumPage()];
  }

  //List of the pages icons
  List<IconData> iconList = [
    Icons.home,
    Icons.video_settings_outlined,
    Icons.update_outlined,
    Icons.person,
  ];

  //List of the pages titles
  List<String> titleList = [
    'Details of Supplier',
    'Add Videos',
    'Update Premium',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              // Sign out the current user
              try {
                await FirebaseAuth.instance.signOut();
                // Navigate to the login screen or home screen after sign out
                // Example:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectUserType(),
                  ),
                );
              } catch (e) {
                print('Error signing out: $e');
                // Handle signout error
              }
            },
            icon: Icon(
              Icons.exit_to_app,
            ),
          ),
        ],
        title: Text(
          titleList[_bottomNavIndex],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xfffef6eb),
        elevation: 0.0,
      ),
      body: IndexedStack(
        index: _bottomNavIndex,
        children: _widgetOptions(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        iconSize: 30,
        backgroundColor: Color(0xfff9a130),
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
