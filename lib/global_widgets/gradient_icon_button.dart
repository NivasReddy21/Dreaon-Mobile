import '../constants/constants.dart';
import 'package:flutter/material.dart';

class GradientIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const GradientIconButton({
    Key key,
    @required this.icon,
    @required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      child: RaisedButton(
        onPressed: onPressed,
        shape: CircleBorder(),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
            gradient: AppConstants.gradient,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
