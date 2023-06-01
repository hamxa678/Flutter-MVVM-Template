

import 'package:flutter_mvvm_template/core/constants/api_end_points.dart';
import 'package:flutter_mvvm_template/core/models/body/login_body.dart';
import 'package:flutter_mvvm_template/core/models/body/reset_password_body.dart';
import 'package:flutter_mvvm_template/core/models/body/signup_body.dart';
import 'package:flutter_mvvm_template/core/models/responses/auth_response.dart';
import 'package:flutter_mvvm_template/core/models/responses/base_responses/base_response.dart';
import 'package:flutter_mvvm_template/core/models/responses/base_responses/request_response.dart';
import 'package:flutter_mvvm_template/core/models/responses/onboarding_response.dart';
import 'package:flutter_mvvm_template/core/models/responses/user_profile_response.dart';
import 'package:flutter_mvvm_template/core/services/api_services.dart';
import 'package:flutter_mvvm_template/locator.dart';

class DatabaseService {
  final ApiServices _apiServices = locator<ApiServices>();

  Future<UserProfileResponse> getUserProfile() async {
    final RequestResponse response =
        await _apiServices.get(endPoint: EndPoints.userProfile);
    return UserProfileResponse.fromJson(response.data);
  }

  Future<OnboardingResponse> getOnboardingData() async {
    final RequestResponse response =
        await _apiServices.get(endPoint: EndPoints.onboardingData);
    return OnboardingResponse.fromJson(response.data);
  }

  Future<BaseResponse> updateFcmToken(String deviceId, String token) async {
    final RequestResponse response = await _apiServices.post(
      endPoint: EndPoints.fcmToken,
      data: {
        'device_id': deviceId,
        'token': token,
      },
    );
    return BaseResponse.fromJson(response.data);
  }

  Future<BaseResponse> clearFcmToken(String deviceId) async {
    final RequestResponse response = await _apiServices.post(
      endPoint: EndPoints.clearFcmToken,
      data: {'device_id': deviceId},
    );
    return BaseResponse.fromJson(response.data);
  }

  Future<AuthResponse> loginWithEmailAndPassword(LoginBody body) async {
    final RequestResponse response = await _apiServices.post(
      endPoint: EndPoints.login,
      data: body.toJson(),
    );
    return AuthResponse.fromJson(response.data);
  }

  Future<AuthResponse> createAccount(SignUpBody body) async {
    final RequestResponse response = await _apiServices.post(
      endPoint: EndPoints.signUp,
      data: body.toJson(),
    );
    return AuthResponse.fromJson(response.data);
  }

  Future<AuthResponse> resetPassword(ResetPasswordBody body) async {
    final RequestResponse response = await _apiServices.post(
      endPoint: EndPoints.resetPassword,
      data: body.toJson(),
    );
    return AuthResponse.fromJson(response.data);
  }
}
