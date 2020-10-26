import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppConstants {
  static const String appName = "Buddy";
  static String primaryFont = GoogleFonts.poppins().fontFamily;

  static const LinearGradient gradient = LinearGradient(
    colors: [AppColors.gradientColor1, AppColors.gradientColor2],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
