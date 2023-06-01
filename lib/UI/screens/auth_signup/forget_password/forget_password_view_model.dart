import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/UI/custom_widget/dialogbox/auth_dialog.dart';
import 'package:flutter_mvvm_template/core/enums/view_state.dart';
import 'package:flutter_mvvm_template/core/models/body/reset_password_body.dart';
import 'package:flutter_mvvm_template/core/models/responses/reset_password_response.dart';
import 'package:flutter_mvvm_template/core/others/base_view_model.dart';
import 'package:flutter_mvvm_template/core/services/firebase_auth_service.dart';
import 'package:get/get.dart';

import '../../../../locator.dart';

class ForgetPasswordScreenViewModel extends BaseViewModel {
  FirebaseAuthService firebaseAuthService = locator<FirebaseAuthService>();
  ResetPasswordBody resetPasswordBody = ResetPasswordBody();
  TextEditingController emailController = TextEditingController();
  late ResetPasswordResponse response;

  resetPassword() async {
    setState(ViewState.busy);
    response = await firebaseAuthService.resetPassword(resetPasswordBody);
    if (!response.success) {
      Get.dialog(AuthDialog(title: 'Title', message: '${response.error}'));
    }
    setState(ViewState.idle);
    Get.back();
  }
}
