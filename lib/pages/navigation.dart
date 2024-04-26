// import 'package:flutter/material.dart';
//
// import '../screens/add_claim.dart';
// import '../screens/home_page.dart';
//
// class NavigationExample extends StatefulWidget {
//   const NavigationExample({super.key});
//
//   @override
//   State<NavigationExample> createState() => _NavigationExampleState();
// }
//
// class _NavigationExampleState extends State<NavigationExample> {
//   int currentPageIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: NavigationBar(
//         onDestinationSelected: (int index) {
//           setState(() {
//             currentPageIndex = index;
//           });
//         },
//         indicatorColor: Color(0xffD9D9D9),
//         selectedIndex: currentPageIndex,
//         backgroundColor: Color(0xff1F36C7),
//         destinations: const <Widget>[
//           NavigationDestination(
//             selectedIcon: Image(
//               image: AssetImage('assets/icon1.png'),
//             ),
//             icon: Image(
//               image: AssetImage('assets/icon1.png'),
//             ),
//             label: 'Home',
//           ),
//           NavigationDestination(
//             selectedIcon: Image(
//               image: AssetImage('assets/icon2.png'),
//             ),
//             icon: Image(
//               image: AssetImage('assets/icon2.png'),
//             ),
//             label: 'Tasks',
//           ),
//           NavigationDestination(
//             selectedIcon: Image(
//               image: AssetImage('assets/icon3.png'),
//             ),
//             icon: Image(
//               image: AssetImage('assets/icon3.png'),
//             ),
//             label: 'Messages',
//           ),
//           NavigationDestination(
//             selectedIcon: Image(
//               image: AssetImage('assets/icon4.png'),
//             ),
//             icon: Image(
//               image: AssetImage('assets/icon4.png'),
//             ),
//             label: 'Translate',
//           ),
//         ],
//       ),
//       body: <Widget>[
//         /// Home page
//         AddClaim(),
//
//         /// Notifications page
//         // TasksPage(),
//
//         /// Messages page
//         // MessagesPage(),
//
//         /// Translate page
//         // MessagesPage(),
//       ][currentPageIndex],
//     );
//   }
// }
