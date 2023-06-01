import 'package:flutter_mvvm_template/core/constants/api_end_points.dart';
import 'package:flutter_mvvm_template/core/models/body/login_body.dart';
import 'package:flutter_mvvm_template/core/models/body/reset_password_body.dart';
import 'package:flutter_mvvm_template/core/models/body/signup_body.dart';
import 'package:flutter_mvvm_template/core/models/responses/auth_response.dart';
import 'package:flutter_mvvm_template/core/models/responses/base_responses/base_response.dart';
import 'package:flutter_mvvm_template/core/models/responses/base_responses/request_response.dart';
import 'package:flutter_mvvm_template/core/models/responses/onboarding_response.dart';
import 'package:flutter_mvvm_template/core/models/responses/user_profile_response.dart';

class FirebaseService {
  Future<UserProfileResponse?> getUserProfile() async {
   return null;
  }

  Future<OnboardingResponse?> getOnboardingData() async {
    return null;
  }

  Future<BaseResponse?> updateFcmToken(String deviceId, String token) async {
    return null;
    
  }

  Future<BaseResponse?> clearFcmToken(String deviceId) async {
    return null;
  }

  Future<AuthResponse?> loginWithEmailAndPassword(LoginBody body) async {
    return null;
  }

  Future<AuthResponse?> createAccount(SignUpBody body) async {
    return null;
  }

  Future<AuthResponse?> resetPassword(ResetPasswordBody body) async {
    return null;
  }
}
