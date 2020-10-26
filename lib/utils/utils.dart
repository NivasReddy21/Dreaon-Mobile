import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Utils {
  static Widget verticalSpacer({double space = 20.0}) {
    return SizedBox(height: space);
  }

  static Widget horizontalSpacer({double space = 20.0}) {
    return SizedBox(width: space);
  }

  static String formatNumber(int value){
    return NumberFormat.compact().format(value);
  }
}
