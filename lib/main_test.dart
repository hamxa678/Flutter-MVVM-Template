import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/app.dart';
import 'package:flutter_mvvm_template/core/enums/env.dart';
import 'package:flutter_mvvm_template/core/others/logger_customizations/custom_logger.dart';
import 'package:flutter_mvvm_template/firebase_options.dart';
import 'locator.dart';

Future<void> main() async {
  final log = CustomLogger(className: 'main');
  try {
    log.i('Testing info logs');
    log.d('Testing debug logs');
    log.e('Testing error logs');
    log.wtf('Testing WTF logs');
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await setupLocator(Env.test);
    runApp(const MyApp(title: 'Test - App Name'));
  } catch (e, s) {
    log.d("$e");
    log.d("$s");
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final log = CustomLogger(className: 'main');
  await Firebase.initializeApp();
  log.d("Handling a background message: ${message.messageId}");
}
