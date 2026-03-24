import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  Future<String> uploadFileToSupabase({
    required File file,
    required String conversationId,
    required String folder,
  }) async {
    final fileName = path.basename(file.path);
    final filePath =
        '$conversationId/$folder/${DateTime.now().millisecondsSinceEpoch}_$fileName';

    await supabase.storage.from('chat-files').upload(filePath, file);
    final publicUrl = supabase.storage
        .from('chat-files')
        .getPublicUrl(filePath);
    return publicUrl;
  }

  Future<String> uploadImageToSupabase({
    String? folder,
    required File file,
  }) async {
    final fileName = path.basename(file.path);
    final filePath =
        '$folder/${DateTime.now().millisecondsSinceEpoch}_$fileName';
    await supabase.storage.from('chat-files').upload(filePath, file);
    final publicUrl = supabase.storage
        .from('chat-files')
        .getPublicUrl(filePath);
    return publicUrl;
  }
}
