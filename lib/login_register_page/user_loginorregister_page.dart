import 'package:flutter/material.dart';

import '../pages/agent_login_page.dart';
import '../pages/user_login_page.dart';


class UserLoginOrRegisterPage extends StatefulWidget {
  final String userType;
  const UserLoginOrRegisterPage({super.key, required this.userType});

  @override
  State<UserLoginOrRegisterPage> createState() => _UserLoginOrRegisterPageState();
}


class _UserLoginOrRegisterPageState extends State<UserLoginOrRegisterPage> {
  // initially  show login page
  bool showLoginPage = true;

  // toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.userType=='claimsagent') {
      return AgentLoginPage(userType: widget.userType);
    } else {
      return UserLoginPage(onTop: togglePages, userType: widget.userType,);
    }
  }
}
