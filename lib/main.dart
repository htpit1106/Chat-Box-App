import 'package:chatbox/core/configs/app_configs.dart';
import 'package:chatbox/core/configs/app_env_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: AppConfigs.env.baseUrl,
    anonKey: AppConfigs.env.anonKey,
  );
  runApp(const ChatBoxApp());
}
