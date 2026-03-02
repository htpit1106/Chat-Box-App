class AppValidator {
  AppValidator._();

  static String? validateEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "This field is required";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter your email";
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  static String? validateMobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter your mobile number";
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return "Please enter a valid mobile number";
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? value,
    String? confirmPassword,
  ) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter your password";
    } else if (value != confirmPassword) {
      return "Password mismatch";
    }
    return null;
  }
}
