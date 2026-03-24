class StringUtils {
  StringUtils._privateConstructor();

  static String getLastName(String? name) {
    if (name == null) return '';
    final names = name.split(' ');
    return names.last;
  }
}
