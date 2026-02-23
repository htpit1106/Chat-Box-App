import 'package:chatbox/data/models/enum/language_type.dart';
import 'package:flutter/material.dart';

import 'app_env_config.dart';

class AppConfigs {
  AppConfigs._();

  static const String appName = "C chat";
  static Environment env = Environment.dev;
  static const ThemeMode defaultThemeMode = ThemeMode.system;

  ///API
  static const Duration apiTimeout = Duration(milliseconds: 60000);

  // splash
  static const String splash = "/splash";
  static const Duration splashMinDisplayTime = Duration(milliseconds: 1000);

  // Paging
  static const pageSize = 50;
  static const pageSizeMax = 1000;
  static const limitGroupOrder = 5;

  static const dateDisplayFormat = 'dd/MM/yyyy';
  static const dateTimeDisplayFormat = 'dd/MM/yyyy HH:mm';

  ///Date range
  static final identityMinDate = DateTime(1900, 1, 1);
  static final identityMaxDate = DateTime.now();
  static final birthMinDate = DateTime(1945, 1, 1);
  static final birthMaxDate = DateTime.now();
  static final minSelectableDate = DateTime(DateTime.now().year - 100);
  static final maxSelectableDate = DateTime(DateTime.now().year + 100);

  ///Text format
  static const textMaxLength = 255;
  static const fontFamily = 'Caros';

  ///Local
  static const appLocal = 'en_US';
  static const appLanguage = 'en';

  ///File
  static const autoDeleteDays = 30;
  static const maxAttachFile = 5;
  static const maxUploadFile = 30;
  static const maxTotalFileSize = 25; //25MB
  static const maxTotalFileSizeInByte = maxTotalFileSize * 1024 * 1024; //25MB

  static const defaultLocal = Locale.fromSubtags(languageCode: appLanguage);
  static const defaultLanguage = Language.english;
}
