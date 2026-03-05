import 'dart:io';

import 'package:chatbox/core/configs/app_configs.dart';
import 'package:chatbox/core/utils/utils.dart';

class ValidatorUtils {
  ValidatorUtils._();

  static RegExp emailRegex = RegExp(
    r'^(?!.*\.\.)[a-zA-Z0-9_-](?:[a-zA-Z0-9._-]*[a-zA-Z0-9_-])?@(?:[a-zA-Z0-9]+(?:-[a-zA-Z0-9]+)*\.)+[a-zA-Z]{2,63}$',
  );
  static RegExp passwordRegex = RegExp(
    r"""^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?])[A-Za-z0-9][A-Za-z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]{7,}$""",
  );
  static RegExp passwordInputRegex = RegExp(
    r"""[A-Za-z\d!@#$%^&*()_+\-=\[\]{};\'":\\|,.<>\/?]""",
  );
  static RegExp kanaRegex = RegExp(r'^[\u3040-\u309f]*$');
  static RegExp numberRegex = RegExp(r'^\d{10,11}$');
  static RegExp phoneNumberRegex = RegExp(
    r'^(([0-9]{1,3}-[0-9]{1,4}-[0-9]{1,4}$)|([0-9]{1,4}-[0-9]{1,4}-[0-9]{1,3}$)|([0-9]{1,4}-[0-9]{1,3}-[0-9]{1,4}$)|([0-9]{1,6}-[0-9]{1,6}$))',
  );
  static RegExp urlRegex = RegExp(
    r'^(https?:\/\/(www\.)?)?[a-z0-9]+([\-\.][a-z0-9]+)*\.[a-z]{2,5}(:\d{1,5})?(\/.*)?$',
    caseSensitive: false,
  );
  static RegExp phoneNumberInputRegex = RegExp(r'[0-9-]');
  static RegExp postalRegex = RegExp(r'^\d{3}\d{4}$');
  static final RegExp textNumberHalfWidthRegex = RegExp(r'^[a-zA-Z0-9]+$');

  static bool isEmptyOrNull(String? value) {
    return value == null || value.isEmpty || value.trim().isEmpty;
  }

  static String? validateEmail(String email) {
    if (!emailRegex.hasMatch(email)) {
      return "Please enter your e-mail address correctly.";
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (isEmptyOrNull(password)) {
      return "Please enter your password.";
    }
    if (!passwordRegex.hasMatch(password!)) {
      return 'Passwords must contain at least 8 characters, including uppercase letters, lowercase letters, numbers, and symbols.';
    }
    return null;
  }

  static String? validateImage({required File? file}) {
    final isWebImage = isWebUrl(file?.path);
    if (isWebImage != null && isWebImage) {
      return null;
    }
    final dotIndex = file?.path.lastIndexOf('.');
    if (dotIndex == -1) {
      return "Invalid file format";
    }
    if (file == null ||
        !['.jpg', '.jpeg', '.png', '.gif', '.webp', '.heic'].contains(
          file.path.toLowerCase().substring(file.path.lastIndexOf('.')),
        )) {
      return "Please upload an image file";
    } else if (file.lengthSync() > AppConfigs.maxTotalFileSizeInByte) {
      return "File size exceeds the limit of ${convertKBToMB(AppConfigs.maxTotalFileSize.toString())}";
    }
    return null;
  }

  static String? validatePhoneNumber(String? phoneNumber) {
    if (isEmptyOrNull(phoneNumber) ||
        !phoneNumberRegex.hasMatch(phoneNumber ?? "")) {
      return "Phone numbers can contain up to 13 numbers, including dashes";
    }
    return null;
  }

  static String? validateUrl(String url) {
    if (isEmptyOrNull(url) || !urlRegex.hasMatch(url)) {
      return "Please enter a valid URL";
    }
    return null;
  }

  static String? validateUploadFile({required List<File> files}) {
    if (files.isEmpty) {
      return "Please upload a file";
    }
    if (files.length > AppConfigs.maxUploadFile) {
      return "You can only upload ${AppConfigs.maxUploadFile} files at a time";
    }
    final maximumImageSizePerFile = convertMBtoByte(
      AppConfigs.maxTotalFileSize,
    );
    for (final file in files) {
      final size = file.lengthSync();
      if (size > maximumImageSizePerFile) {
        return "File size exceeds the limit of ${convertKBToMB(AppConfigs.maxTotalFileSize.toString())}";
      }
    }
    return null;
  }
}
