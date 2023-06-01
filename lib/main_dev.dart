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

  /// Testing logs
  try {
    log.i('Testing info logs');
    log.d('Testing debug logs');
    log.e('Testing error logs');
    log.wtf('Testing WTF logs');
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      /// These options file is generated by flutterfire
      options: DefaultFirebaseOptions.currentPlatform,
    );

    /// Initializing Firebase Messaging
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await setupLocator(Env.dev);
    runApp(const MyApp(title: 'Dev - App Name'));
  } catch (e, s) {
    log.d("$e");
    log.d("$s");
  }
}

/// This is a background message handler function which handles messages when the app is in background
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final log = CustomLogger(className: 'main');
  await Firebase.initializeApp();
  log.d("Handling a background message: ${message.messageId}");
}
