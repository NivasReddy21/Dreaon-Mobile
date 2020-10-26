import 'dart:async';

import '../../../constants/routes.dart';

import '../../../utils/utils.dart';
import '../../../global_widgets/custom_button.dart';
import '../../../views/auth/landing/widgets/social_button.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../constants/images.dart';
import 'package:flutter/material.dart';
import '../../../config/extensions.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List<String> imageList = [
    AppImages.landingBanner,
    AppImages.landingBanner2,
    AppImages.landingBanner3,
    AppImages.landingBanner4,
    AppImages.landingBanner5,
  ];
  int currentSelected = 0;
  String bgImage = AppImages.landingBanner;
  Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) {
      setState(() {
        if (currentSelected == imageList.length) {
          currentSelected = 0;
        }
        currentSelected++;
        bgImage = imageList[currentSelected - 1];
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size mediaQuerySize = MediaQuery.of(context).size;

    final backgroundImage = ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.transparent],
        ).createShader(
          Rect.fromLTRB(0, 0, rect.width, rect.height),
        );
      },
      blendMode: BlendMode.dstIn,
      child: Image.asset(
        bgImage,
        fit: BoxFit.cover,
      ),
    );

    final title = Container(
      child: Text(
        "Find new \nfriends nearby",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: 40.0,
        ),
      ),
    ).fadeIn(1);

    final subtitle = Container(
      child: Text(
        "With millions of users all over the world, we give you the ability to connect with people no matter where you are.",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    ).fadeIn(2);

    final signUpBtn = CustomButton(
      text: "Get Started",
      onPressed: () => Navigator.of(context).pushReplacementNamed(
        AppRoutes.register,
      ),
    ).fadeIn(3);

    final loginBtn = CustomButton(
      text: "Login",
      color: Colors.white,
      isGradient: false,
      textColor: Theme.of(context).primaryColor,
      onPressed: () => Navigator.of(context).pushReplacementNamed(
        AppRoutes.login,
      ),
    ).fadeIn(4);

    final orText = Container(
      alignment: Alignment.center,
      child: Text(
        "Or continue with",
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
    ).fadeIn(5);

    final socialBtns = Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SocialButton(
            icon: FlutterIcons.google_ant,
            backgroundColor: Color(0xFFDB4437),
          ),
          SocialButton(
            icon: FlutterIcons.facebook_ent,
            backgroundColor: Color(0xFF4267B2),
          ),
          SocialButton(
            icon: FlutterIcons.twitter_ant,
            backgroundColor: Color(0xFF1DA1F2),
          ),
        ],
      ),
    ).fadeIn(6);

    final content = SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Utils.verticalSpacer(space: mediaQuerySize.height * 0.3),
          title,
          Utils.verticalSpacer(space: 10),
          subtitle,
          Utils.verticalSpacer(space: 40.0),
          signUpBtn,
          Utils.verticalSpacer(space: 10),
          loginBtn,
          Utils.verticalSpacer(space: 40),
          orText,
          socialBtns,
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[backgroundImage, content],
      ),
    );
  }
}
