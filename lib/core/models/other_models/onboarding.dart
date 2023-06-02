import 'package:flutter_mvvm_template/core/services/localization_service.dart';

class Onboarding {
  late String? imgUrl;
  late String? title;

  Onboarding({this.imgUrl, this.title});

    factory Onboarding.fromMap(map) {
    return Onboarding(
      imgUrl : map['image_url'],
      title : map[LocalizationService.getLocalizedKey('title')],
    );
  }
}
