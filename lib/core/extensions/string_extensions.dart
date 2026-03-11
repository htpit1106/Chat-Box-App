import 'package:chatbox/core/utils/validator_utils.dart';
import 'package:chatbox/generated/l10n.dart';
import 'package:flutter/cupertino.dart';

extension StringExtensions on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  bool isValidEmail() {
    return ValidatorUtils.emailRegex.hasMatch(this);
  }

  bool isValidPassword() {
    return ValidatorUtils.passwordRegex.hasMatch(this);
  }

  bool isNumber() {
    return ValidatorUtils.numberRegex.hasMatch(this);
  }
}

extension BuildContextExt on BuildContext {
  S get l10 {
    return S.of(this);
  }
}
