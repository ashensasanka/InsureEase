import 'package:app/pages/customer_root_page.dart';
import 'package:app/pages/select_user_type.dart';
import 'package:app/screens/forum_page.dart';
import 'package:app/screens/quizes_page.dart';
import 'package:app/screens/video_tutorials.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'controller/home_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Get.put(HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SelectUserType(),
      routes: {
        // '/': (context) => HoverPage(),
        '/videos': (context) => VideoTutorialPage(), // Default route to SignInPage
        '/home': (context) => CustomerRootPage(), // Route to HomePage
        '/quizes': (context) => QuizesPage(), // Route to ItemPage
        '/community': (context) => ForumPage()
        // Other routes...
      },
    );
  }
}
