
import 'package:flutter_mvvm_template/core/models/other_models/onboarding.dart';
import 'package:flutter_mvvm_template/core/services/local_storage_service.dart';
import 'package:logger/logger.dart';
import '../../../core/others/base_view_model.dart';
import '../../../locator.dart';

class OnboardingViewModel extends BaseViewModel {
  final Logger log = Logger();
  late int currentPageIndex;
  late List<Onboarding> onboardingList;
  final _localStorageService = locator<LocalStorageService>();

  OnboardingViewModel(this.currentPageIndex, this.onboardingList);

  updatePage(index) {
    log.d('@updateOnboarding page with index: $index');
    currentPageIndex = index;
    _localStorageService.onBoardingPageCount = index;
    notifyListeners();
  }
}
