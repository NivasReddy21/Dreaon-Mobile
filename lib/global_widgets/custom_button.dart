import '../constants/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color color;
  final Color textColor;
  final bool isGradient;
  final bool wrap;

  const CustomButton({
    Key key,
    @required this.text,
    @required this.onPressed,
    this.color,
    this.textColor,
    this.isGradient = true,
    this.wrap = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double btnSize = 55.0;

    final btnText = Text(
      text.toUpperCase(),
      style: TextStyle(
        fontWeight: FontWeight.w800,
        color: textColor ?? Colors.white,
      ),
    );

    final materialBtn = MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      height: btnSize,
      color: color ?? Theme.of(context).primaryColor,
      elevation: 4.0,
      onPressed: onPressed,
      child: Center(
        child: btnText,
      ),
    );

    final gradientBtn = Container(
      height: wrap ? null : btnSize,
      child: RaisedButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80.0),
        ),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.gradientColor1, AppColors.gradientColor2],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Container(
            constraints: wrap
                ? BoxConstraints(minWidth: 88, minHeight: 35)
                : BoxConstraints(maxWidth: 500.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: btnText,
          ),
        ),
      ),
    );

    return isGradient ? gradientBtn : materialBtn;
  }
}
