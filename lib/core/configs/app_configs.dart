import 'dart:ui';

import 'package:chatbox/data/models/enum/language_type.dart';

class AppConfigs {
  AppConfigs._();

  static const String appName = "C chat";

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

  static const defaultLocal = Locale.fromSubtags(languageCode: appLanguage);
  static const defaultLanguage = Language.english;
}
