import 'package:flutter/widgets.dart';
import 'package:flutter_mvvm_template/core/enums/view_state.dart';
import 'package:flutter_mvvm_template/core/models/body/login_body.dart';
import 'package:flutter_mvvm_template/core/models/responses/auth_response.dart';
import 'package:flutter_mvvm_template/core/others/base_view_model.dart';
import 'package:flutter_mvvm_template/core/services/firebase_auth_service.dart';
import 'package:flutter_mvvm_template/locator.dart';
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

  login() async {
    setState(ViewState.busy);
    loginBody.email = emailController.text;
    loginBody.password = passwordController.text;
    await firebaseAuthService.loginWithEmailAndPassword(loginBody);
    setState(ViewState.idle);
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
