import 'package:get/get.dart';
import 'package:logger/logger.dart';

class LocalizationService extends Translations {
  final log = Logger();
  static getLocalizedKey(String key) {
    String currentLanguageCode = Get.locale!.languageCode;
    Logger().d('Localized key is: ${key}_$currentLanguageCode');
    return '${key}_$currentLanguageCode';
  }

  @override
  Map<String, Map<String, String>> get keys {
    const Map<String, String> english = {
      "hello": "Hello world!",
      "network_error_title": "Network Error",
      "network_error_content": "Please check your internet connection",
    };

    const Map<String, String> arabic = {
      "hello": '!مرحبا بالعالم',
      "network_error_title": 'خطأ في الشبكة',
      "network_error_content": "الرجاء التحقق من اتصال الانترنت الخاص بك"
    };

    return {
      'en': english,
      'ar': arabic,
    };
  }
}
