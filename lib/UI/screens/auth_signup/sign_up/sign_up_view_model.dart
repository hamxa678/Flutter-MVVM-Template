import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/UI/custom_widget/dialogbox/auth_dialog.dart';
import 'package:flutter_mvvm_template/UI/screens/root/root_screen.dart';
import 'package:flutter_mvvm_template/core/enums/view_state.dart';
import 'package:flutter_mvvm_template/core/models/body/signup_body.dart';
import 'package:flutter_mvvm_template/core/models/responses/auth_response.dart';
import 'package:flutter_mvvm_template/core/others/base_view_model.dart';
import 'package:flutter_mvvm_template/core/services/firebase_auth_service.dart';
import 'package:flutter_mvvm_template/core/services/file_picker_service.dart';
import 'package:get/get.dart';

import '../../../../locator.dart';

class SignUpViewModel extends BaseViewModel {
  final FirebaseAuthService _FirebaseAuthService =
      locator<FirebaseAuthService>();
  final FilePickerService _imagePickerService = locator<FilePickerService>();
  int? selectedGenderIndex;
  SignUpBody signUpBody = SignUpBody();
  late AuthResponse response;

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  bool passwordVisibility = true;

  togglePasswordVisibility() {
    setState(ViewState.busy);
    passwordVisibility = !passwordVisibility;
    setState(ViewState.idle);
  }

  updateIndex(val) {
    selectedGenderIndex = val;
    notifyListeners();
  }

  requestSignUp() async {
    setState(ViewState.busy);
    signUpBody.gender = selectedGenderIndex == 0 ? "Male" : "Female";
    response =
        await _FirebaseAuthService.signupWithEmailAndPassword(signUpBody);
    if (!response.success) {
      Get.dialog(const AuthDialog(title: 'Title', message: 'Message here...'));
    } else {
      Get.offAll(const RootScreen());
    }
    setState(ViewState.idle);
  }

  pickImage() async {
    signUpBody.image = await _imagePickerService.pickImage();
    notifyListeners();
  }
}
