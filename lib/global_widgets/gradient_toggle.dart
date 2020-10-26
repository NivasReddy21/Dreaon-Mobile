import '../constants/constants.dart';
import 'package:flutter/material.dart';

class GradientToggle extends StatelessWidget {
  final bool value;
  final VoidCallback onChanged;

  const GradientToggle({
    Key key,
    @required this.value,
    @required this.onChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = 30.0;

    return GestureDetector(
      onTap: onChanged,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: value ? AppConstants.gradient : null,
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: value ? 0 : 2,
          ),
        ),
        child: Center(
          child: Icon(
            value ? Icons.check : Icons.add,
            color: value ? Colors.white : Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
