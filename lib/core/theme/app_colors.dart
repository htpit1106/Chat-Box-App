import 'dart:ui';

class AppColors {
  AppColors._();
  ///Common
  static const Color primary = Color(0xFF24786D);
  static const Color secondary = Color(0xFFF2F7FB);
  static const Color tertiary = Color(0xFF797C7B);

  ///Background
  static const Color splashBackground = Color(0xFFFFFFFF);
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF000E08);
  static const Color backgroundRed = Color(0xFFFF2D1B);
  static const Color greyCD = Color(0xFFCDD1D0);

  ///Border
  static const Color borderSilverGray = Color(0xFF606060);
  static const Color borderBlack = Color(0xFF000E08);
  static const Color borderDarkGreen = Color(0xFF363F3B);

  ///Divider
  static const Color divider = Color(0xFFCDD1D0);

  ///Text
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textBlack = Color(0xFF000E08);
  static const Color textGreen = primary;
  static const Color textRed = Color(0xFFFF2D1B);
  static const Color textGrey = tertiary;

  ///TextField
  static const Color textFieldEnabledUnderline = greyCD;
  static const Color textFieldFocusedBorder = greyCD;

  static const Color textFieldDisabledUnderline = greyCD;
  static const Color textFieldPrimaryUnderline = greyCD;
  static const Color textFieldCursor = Color(0xFF919191);
  static const Color textFieldErrorUnderline = backgroundRed;

  /// button
  static const Color buttonGreen = Color(0xFF20A090);
  static const Color buttonGray = tertiary;

}