import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/images.dart';
import '../../constants/routes.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool loggedIn;
  Future<void> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loggedIn = prefs.getBool('loggedIn');
  }

  startTimer() async {
    var _duration = Duration(seconds: 1);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    bool showOnboarding = true;
    String viewToShow = AppRoutes.landing;
    if (showOnboarding) {
      viewToShow = AppRoutes.onboarding;
    }
    if (loggedIn == true) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.tabs);
    } else if (loggedIn == false) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.login);
    } else if (loggedIn == null) {
      Navigator.of(context).pushReplacementNamed(viewToShow);
    }
  }

  @override
  void initState() {
    isLoggedIn();
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Image.asset(
            AppImages.logo,
            height: 120.0,
          ),
        ),
      ),
    );
  }
}
