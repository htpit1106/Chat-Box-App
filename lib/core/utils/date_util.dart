import 'package:intl/intl.dart';

class DateUtil {
  DateUtil._();
  static DateTime? convertStringToDate(String date) {
    if (date.isEmpty) return null;
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.parse(date);
  }

  // format date chat
  // inday: show hour ago
  // in week: show day ago
  // else: show date dd/MM/yyyy
  static String? formatDateChat(DateTime? date) {
    if (date == null) return null;
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inSeconds < 60) {
      return "${diff.inSeconds}s ago";
    }

    if (diff.inMinutes < 60) {
      return "${diff.inMinutes}m ago";
    }

    if (diff.inHours < 24) {
      return "${diff.inHours}h ago";
    } else if (diff.inDays < 7) {
      return "${diff.inDays} days ago";
    } else {
      final formatter = DateFormat('dd/MM/yyyy');
      return formatter.format(date);
    }
  }
}

extension FormatDateTime on DateTime? {
  String get formatDefaultDateYYYYMMDD {
    if (this == null) return "";
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(this!);
  }
}
