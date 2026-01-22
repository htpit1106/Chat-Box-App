import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemes {
  static const _font = 'Caros';

  // light theme

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      fontFamily: _font,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      textTheme: TextTheme(
          labelLarge: AppTextStyle.primary.s16.bold
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.divider, width: 1),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 1),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      fontFamily: _font,
      textTheme: TextTheme(
        labelLarge: AppTextStyle.white.s16.bold
      ),
      scaffoldBackgroundColor: AppColors.backgroundDark,
      inputDecorationTheme: InputDecorationTheme(

        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.textWhite, width: 1),
        ),

        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.textWhite, width: 1),
        ),
      ),
    );
  }
}
