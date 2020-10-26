import '../../constants/images.dart';
import '../../constants/routes.dart';
import '../../views/onboarding/widgets/dot_indicator.dart';

import 'widgets/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentPage = 0;
  List<Color> colors = [
    Color(0xFFEE8778),
    Color(0xFFF26993),
    Color(0xFF58BAB8),
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      OnboardingView.show(
        context: context,
        color: colors[0],
        image: AppIll.slider1,
        title: "Find new friends nearby",
        subtitle: "Be social, find friends and mingle",
      ),
      OnboardingView.show(
        context: context,
        color: colors[1],
        image: AppIll.slider2,
        title: "Be together, anytime, anywhere",
        subtitle:
            "A simple way to text, video chat and watch live streams all in one place",
      ),
      OnboardingView.show(
        context: context,
        color: colors[2],
        image: AppIll.slider3,
        title: "Most importantly, have fun!",
        subtitle: "Hang out with friends and attend events",
      ),
    ];

    final skipBtn = Positioned(
      bottom: 20,
      right: 20,
      child: Visibility(
        visible: currentPage != 2,
        child: GestureDetector(
          onTap: () => Navigator.pushReplacementNamed(
            context,
            AppRoutes.landing,
          ),
          child: Text(
            "SKIP",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );

    final getStartedBtn = Positioned(
      bottom: 20,
      right: 20,
      child: Visibility(
        visible: currentPage == 2,
        child: GestureDetector(
          onTap: () => Navigator.pushReplacementNamed(
            context,
            AppRoutes.landing,
          ),
          child: Row(
            children: <Widget>[
              Text(
                "GET STARTED",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Icon(
                Icons.arrow_right,
                color: Colors.white,
                size: 32,
              )
            ],
          ),
        ),
      ),
    );

    final indicators = Positioned(
      left: 20.0,
      bottom: 30.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildIndicators(),
      ),
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          LiquidSwipe(
            pages: pages,
            enableSlideIcon: false,
            enableLoop: false,
            positionSlideIcon: -0.1,
            onPageChangeCallback: (int index) {
              setState(() {
                currentPage = index;
              });
            },
          ),
          skipBtn,
          getStartedBtn,
          indicators,
        ],
      ),
    );
  }

  List<Widget> _buildIndicators() {
    List<Widget> list = [];
    for (int i = 0; i < 3; i++) {
      list.add(
        i == currentPage
            ? DotIndicator(isActive: true, index: i)
            : DotIndicator(isActive: false, index: i),
      );
    }
    return list;
  }
}
