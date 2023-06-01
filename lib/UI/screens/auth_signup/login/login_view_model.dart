import 'package:flutter/widgets.dart';
import 'package:flutter_mvvm_template/core/enums/view_state.dart';
import 'package:flutter_mvvm_template/core/models/body/login_body.dart';
import 'package:flutter_mvvm_template/core/models/responses/auth_response.dart';
import 'package:flutter_mvvm_template/core/others/base_view_model.dart';
import 'package:flutter_mvvm_template/core/services/auth_service.dart';
import 'package:logger/logger.dart';

class LoginViewModel extends BaseViewModel {
  final log = Logger();
  bool isRememberMe = false;
  AuthService authService = AuthService();
  LoginBody loginBody = LoginBody();
  late AuthResponse response;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool passwordVisibility = true;

  togglePasswordVisibility() {
    setState(ViewState.busy);
    passwordVisibility = !passwordVisibility;
    setState(ViewState.idle);
  }

  requestLogin() async {
    setState(ViewState.busy);
    try {
      response = await authService.loginWithEmailAndPassword(loginBody);
    } catch (e, s) {
      log.d("@LoginViewModel requestLogin Exceptions : $e");
      log.d(s);
    }
    setState(ViewState.idle);
  }

  toggleIsRememberMe() {
    debugPrint('@toggleIsRememberMe: isRememberMe: $isRememberMe');
    isRememberMe = !isRememberMe;
    notifyListeners();
  }
}
