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
    };

    const Map<String, String> arabic = {
      "hello": '!مرحبا بالعالم',
    };

    return {
      'en': english,
      'ar': arabic,
    };
  }
}
