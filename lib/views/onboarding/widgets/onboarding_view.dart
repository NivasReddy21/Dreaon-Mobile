import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class OnboardingView {
  static Container show({
    @required BuildContext context,
    @required Color color,
    @required String title,
    @required String subtitle,
    @required String image,
  }) {
    final Size mediaQuerySize = MediaQuery.of(context).size;
    final double imageSize = 300.0;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      color: color,
      height: mediaQuerySize.height,
      width: mediaQuerySize.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WebsafeSvg.asset(
            image,
            width: imageSize,
            height: imageSize,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.start
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
            ),
             textAlign: TextAlign.start
          )
        ],
      ),
    );
  }
}
