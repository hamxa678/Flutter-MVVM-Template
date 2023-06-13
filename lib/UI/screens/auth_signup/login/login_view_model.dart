import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mvvm_template/UI/screens/auth_signup/sign_up/sign_up_screen.dart';
import 'package:flutter_mvvm_template/UI/screens/root/root_screen.dart';
import 'package:flutter_mvvm_template/core/enums/view_state.dart';
import 'package:flutter_mvvm_template/core/models/body/login_body.dart';
import 'package:flutter_mvvm_template/core/others/base_view_model.dart';
import 'package:flutter_mvvm_template/core/services/firebase_auth_service.dart';
import 'package:flutter_mvvm_template/locator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class LoginViewModel extends BaseViewModel {
  final log = Logger();
  FirebaseAuthService firebaseAuthService = locator<FirebaseAuthService>();
  LoginBody loginBody = LoginBody();
  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  /// skillsAndProjectsController screen textfield controller
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ///  for toggling password visibility
  togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  loginWithEmailAndPassword() async {
    setState(ViewState.busy);
    loginBody.email = emailController.text;
    loginBody.password = passwordController.text;
    bool successLogin =
        await firebaseAuthService.loginWithEmailAndPassword(loginBody);
    (successLogin)
        ? Get.offAll(const RootScreen())
        : Get.snackbar("Error", "Login Error");
    setState(ViewState.idle);
  }

  loginWithGoogle() async {
    User? user = await firebaseAuthService.signInWithGoogle();
    if (user != null) {
      Get.to(SignUpScreen(user: user));
    } else {
      Get.snackbar("Error", "Login Error");
    }
    // user ?? Get.to(SignUpScreen(user: user));
    // (successLogin)
    //     ? Get.offAll(const RootScreen())
    //     : Get.snackbar("Error", "Login Error");
    // setState(ViewState.idle);
  }

  /// dispose controllers
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
