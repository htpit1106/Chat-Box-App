import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:image_picker/image_picker.dart';

String formatSize(double? size) {
  if (size == null) return "0.00KB";
  return "${size.toStringAsFixed(2)}KB";
}

String convertKBToMB(String sizeInKbString) {
  double sizeInKb = double.tryParse(sizeInKbString) ?? 0;
  double sizeInMb = sizeInKb / 1024;

  return "${sizeInMb.toStringAsFixed(2)}MB";
}

String generateTimestampFileName({String prefix = '', String suffix = 'zip'}) {
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  return '$prefix$timestamp.$suffix';
}

int convertMBtoByte(int mb) {
  return mb * 1024 * 1024;
}
//
// Future<DateTime?> openDatePicker(
//   BuildContext context, {
//   DateTime? initialDate,
//   DateTime? firstDate,
//   DateTime? lastDate,
// }) async {
//   return await showDialog(
//     context: context,
//     builder: (context) {
//       return AppDatePicker(
//         initialDate: initialDate,
//         firstDate: firstDate,
//         lastDate: lastDate,
//       );
//     },
//   );
// }

Future<TimeOfDay?> openTimePicker(
  BuildContext context, {
  TimeOfDay? initialTime,
}) async {
  final now = DateTime.now();

  final initialDateTime = DateTime(
    now.year,
    now.month,
    now.day,
    initialTime?.hour ?? now.hour,
    initialTime?.minute ?? now.minute,
  );

  TimeOfDay selectedTime = TimeOfDay(
    hour: initialDateTime.hour,
    minute: initialDateTime.minute,
  );

  return await showCupertinoModalPopup<TimeOfDay>(
    context: context,
    builder: (_) => Container(
      color: Theme.of(context).colorScheme.surface,
      height: MediaQuery.sizeOf(context).height * 0.3,
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                use24hFormat: true,
                initialDateTime: initialDateTime,
                onDateTimeChanged: (DateTime newDateTime) {
                  selectedTime = TimeOfDay(
                    hour: newDateTime.hour,
                    minute: newDateTime.minute,
                  );
                },
              ),
            ),
            // AppFilledButton(
            //   onPressed: () {
            //     Navigator.pop(context, selectedTime);
            //   },
            //   text: S.of(context).common_btn_ok,
            // ),
          ],
        ),
      ),
    ),
  );
}

bool isImageFile(String fileName) {
  final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp'];
  return imageExtensions.any((ext) => fileName.toLowerCase().endsWith(ext));
}

Map<String, String> generateFontSizeMap(List<int> sizes) {
  return {for (var size in sizes) '${size}pt': size.toString()};
}

bool? isWebUrl(String? url) {
  if (url == null || url.isEmpty) return null;
  final uri = Uri.tryParse(url);
  if (uri == null) return false;
  return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
}

bool isBase64(String input) {
  final regex = RegExp(r'^data:image\/[a-zA-Z]+;base64,');
  return regex.hasMatch(input);
}

Future<String> imageToBase64(File imageFile) async {
  final bytes = await imageFile.readAsBytes();
  return "data:image/jpeg;base64,${base64Encode(bytes)}";
}

Future<ui.Image> getImageFromFile(File file) async {
  final bytes = await file.readAsBytes();
  final codec = await ui.instantiateImageCodec(bytes);
  final frame = await codec.getNextFrame();
  return frame.image;
}

Future<Size> getImageSize(File file) async {
  final image = await getImageFromFile(file);
  return Size(image.width.toDouble(), image.height.toDouble());
}

String replaceTextSizeUnit(String html) {
  return html.replaceAll('pt', 'px');
}

String fixHtmlColors(String html) {
  final colorRegex = RegExp(
    r'(color|background-color)\s*:\s*(#[0-9A-Fa-f]{8})',
  );
  return html.replaceAllMapped(colorRegex, (match) {
    final prop = match.group(1);
    final color = match.group(2);
    final normalized = normalizeColor(color);
    return '$prop: $normalized';
  });
}

String removeAlphaColor(String html) {
  final colorRegex = RegExp(
    r'(color|background-color)\s*:\s*(#[0-9A-Fa-f]{8})',
  );
  return html.replaceAllMapped(colorRegex, (match) {
    final prop = match.group(1);
    final color = match.group(2);
    final normalized = removeAlphaFromColor(color);
    return '$prop: $normalized';
  });
}

String? removeAlphaFromColor(String? color) {
  if (color == null) return null;
  if (color.length == 9 && color.startsWith('#')) {
    // #RRGGBBAA → #RRGGBB
    final rgb = color.substring(1, 7);
    return '#$rgb';
  }
  return color;
}

String? normalizeColor(String? color) {
  if (color == null) return null;
  if (color.length == 9 && color.startsWith('#')) {
    // #RRGGBBAA → #AARRGGBB
    final alpha = color.substring(7);
    final rgb = color.substring(1, 7);
    return '#$alpha$rgb';
  }
  return color;
}

String addMentionClassIfCodeExists(String html) {
  final mentionRegex = RegExp(r'<code([^>]*)>', dotAll: true);
  final codeOpenRegex = RegExp(r'<pre([^>]*)>', caseSensitive: false);
  final codeCloseRegex = RegExp(r'</pre>', caseSensitive: false);
  final quoteRegex = RegExp(r'<blockquote([^>]*)>', caseSensitive: false);

  html = html.replaceAll(
    quoteRegex,
    '<blockquote class="tiny-editor-blockquote">',
  );
  html = html.replaceAll(mentionRegex, '<code class="mention">');
  html = html.replaceAll(codeOpenRegex, '<code>');
  html = html.replaceAll(codeCloseRegex, '</code>');
  return html;
}

bool isKeyboardOpen(BuildContext context) {
  return MediaQuery.of(context).viewInsets.bottom > 0;
}

void hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

Future<List<File>> pickFiles() async {
  final result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    type: FileType.custom,
    allowedExtensions: [
      'pdf',
      'doc',
      'docx',
      'xls',
      'xlsx',
      'ppt',
      'pptx',
      'txt',
      'zip',
    ],
  );
  if (result == null) return [];

  return result.paths.map((path) => File(path!)).toList();
}

Future<List<XFile>?> pickImages() async {
  final result = await ImagePicker().pickMultiImage(limit: 10);
  return result.map((file) => XFile(file.path)).toList();
}

Future<File?> pickImage() async {
  final result = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (result == null) return null;
  return File(result.path);
}

String decodeContent(String? text) {
  if (text == null || text.isEmpty) return '';
  final unescape = HtmlUnescape();
  text = unescape.convert(text);
  return text;
}

bool isYoutubeUrl(String url) {
  final patterns = [
    // https://www.youtube.com/watch?v=VIDEO_ID
    RegExp(r'youtube\.com/watch\?v=([a-zA-Z0-9_-]{11})'),

    // https://youtu.be/VIDEO_ID
    RegExp(r'youtu\.be/([a-zA-Z0-9_-]{11})'),

    // https://www.youtube.com/embed/VIDEO_ID
    RegExp(r'youtube\.com/embed/([a-zA-Z0-9_-]{11})'),

    // https://www.youtube-nocookie.com/embed/VIDEO_ID
    RegExp(r'youtube-nocookie\.com/embed/([a-zA-Z0-9_-]{11})'),
  ];
  for (final pattern in patterns) {
    final match = pattern.firstMatch(url);
    if (match != null) {
      return true;
    }
  }
  return false;
}

String stripHtmlKeepTextRemoveIframe(String? html) {
  if (html == null || html.isEmpty) return '';

  String result = html;
  result = result.replaceAll(
    RegExp(r'<iframe\b[^>]*>[\s\S]*?<\/iframe>', caseSensitive: false),
    '',
  );

  result = result.replaceAll(RegExp(r'<[^>]+>'), '');

  result = result
      .replaceAll('&nbsp;', ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();

  return result;
}
