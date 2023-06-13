import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_mvvm_template/core/models/body/login_body.dart';
import 'package:flutter_mvvm_template/core/models/body/reset_password_body.dart';
import 'package:flutter_mvvm_template/core/models/body/signup_body.dart';
import 'package:flutter_mvvm_template/core/models/other_models/user_profile.dart';
import 'package:flutter_mvvm_template/core/others/logger_customizations/custom_logger.dart';
import 'package:flutter_mvvm_template/core/services/firebase_service.dart';
import 'package:flutter_mvvm_template/core/services/local_storage_service.dart';
import 'package:flutter_mvvm_template/locator.dart';
import 'package:get/get.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../UI/custom_widget/dialogbox/auth_dialog.dart';

///
/// [FirebaseAuthService] class contains all authentication related logic with following
/// methods:
///
/// [doSetup]: This method contains all the initial authentication like checking
/// login status, onboarding status and other related initial app flow setup.
///
/// [signupWithEmailAndPassword]: This method is used for signup with email and password.
///
/// [signupWithApple]:
///
/// [signupWithGmail]:
///
/// [signupWithFacebook]:
///
/// [logout]:
///

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? get currentUser => _auth.currentUser;
  String? get currentUserUID => currentUser!.uid;
  DocumentReference get documentReference =>
      _firestore.collection('users').doc(currentUserUID);

  late bool isLogin;
  final _localStorageService = locator<LocalStorageService>();
  final _firebaseService = locator<FirebaseService>();
  UserProfile? userProfile;
  String? fcmToken;
  static final Logger log = CustomLogger(className: 'FirebaseAuthService');

  ///
  /// [doSetup] Function does the following things:
  ///   1) Checks if the user is logged then:
  ///       a) Get the user profile data
  ///       b) Updates the user FCM Token
  ///
  doSetup() async {
    isLogin = _localStorageService.isLogin != null;
    if (isLogin) {
      log.d('User is already logged-in');
      await _getUserProfile();
      await _updateFcmToken();
    } else {
      log.d('@doSetup: User is not logged-in');
    }
  }

  /// [_getUserProfile] method is used for getting user profile data.
  _getUserProfile() async {
    userProfile = await _firebaseService.getUserProfile();
  }

  /// Updating FCM Token here
  _updateFcmToken() async {
    // final fcmToken = await locator<NotificationsService>().getFcmToken();
    // final deviceId = await DeviceInfoService().getDeviceId();
    // final response = await _dbService.updateFcmToken(deviceId!, fcmToken!);
    // if (response.success) {
    //   userProfile!.fcmToken = fcmToken;
    // }
  }

  /// [loginWithEmailAndPassword] method is used for login with email and password.
  Future<bool> loginWithEmailAndPassword(LoginBody loginBody) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: loginBody.email!, password: loginBody.password!);
      log.i("@loginWithEmailAndPassword :: $userCredential");
      isLogin = true;
      _localStorageService.isLogin = true;
      await _getUserProfile();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("Invaid Login", "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        Get.snackbar("Invaid Login", "Wrong password provided for that user.");
      }
    }
    return false;

    // late AuthResponse response;
    // response = await _dbService.loginWithEmailAndPassword(body);
    // if (response.success) {
    //   _localStorageService.accessToken = response.accessToken;
    //   await _getUserProfile();
    //   _updateFcmToken();
    // }
    // return response;
  }

  /// [signupWithEmailAndPassword] method is used for signup with email and password.
  Future<bool> signupWithEmailAndPassword(SignUpBody signUpBody) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
              email: signUpBody.email!, password: signUpBody.password!)
          .whenComplete(() async {
        await addUserDetail(signUpBody);
      });
      log.i("@signupWithEmailAndPassword :: $userCredential");
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log.i('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log.i('The account already exists for that email.');
      }
    } catch (e) {
      log.e(e);
    }
    return false;
    // late AuthResponse response;
    // response = await _dbService.createAccount(body);
    // if (response.success) {
    //   userProfile = UserProfile.fromJson(body.toJson());
    // _localStorageService.accessToken = response.accessToken;
    //   await _updateFcmToken();
    // }
    // return response;
  }

  /// [signInWithGoogle] method is used for signup with google.
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final signInMethods =
          await _auth.fetchSignInMethodsForEmail(googleUser.email);
      if (signInMethods.contains('password')) {
        Get.snackbar('Error', 'User with the same email already exists!');
        return null;
      } else {
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        final User user = userCredential.user!;
        return user;
      }
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
    return null;
  }

  /// [signInWithFacebook] method is used for signup with facebook.
  signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken!;
      final OAuthCredential credential =
          FacebookAuthProvider.credential(accessToken.token);
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;
    }
  }

  /// [signInWithApple] method is used for signup with Apple.
  signInWithApple() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );
    final UserCredential userCredential =
        await _auth.signInWithCredential(oauthCredential);
    final User? user = userCredential.user;
  }

  /// [signInWithGithub] method is used for signup with Github.
  signInWithGithub(
      String clientId, String clientSecret, BuildContext context) async {
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: clientId,
        clientSecret: clientSecret,
        redirectUrl: 'https://my-project.firebaseapp.com/__/auth/handler');
    final result = await gitHubSignIn.signIn(context);
    final githubAuthCredential = GithubAuthProvider.credential(result.token!);
    final UserCredential userCredential =
        await _auth.signInWithCredential(githubAuthCredential);
    final User? user = userCredential.user;
  }

  /// [deleteAccount] method is used for deleting user account and [deleteUserDetail] will delete the data of respected user..
  deleteAccount() async {
    await currentUser!.delete().whenComplete(() {
      deleteUserDetail();
    });
  }

  /// [addUserDetail] method is used for adding user details in firestore during signup.
  Future<bool> addUserDetail(SignUpBody signUpBody) async {
    await documentReference.set(signUpBody.toMap()).whenComplete(() {
      userProfile = UserProfile.fromMap(signUpBody.toMap());
      _localStorageService.isLogin = true;
    });
    return true;
  }

  /// This method is used for deleting user details in firestore.
  deleteUserDetail() async {
    await documentReference.delete();
  }

  /// [resetPassword] method is used for reset password.
  resetPassword(ResetPasswordBody resetPasswordBody) async {
    await _auth.sendPasswordResetEmail(email: resetPasswordBody.email!);
    log.i('EMAIL SENT Password reset email successfully sent.');
    // final AuthResponse response = await _dbService.resetPassword(body);
    // if (response.success) {
    //   _localStorageService.accessToken = response.accessToken;
    // }
    // return response;
  }

  Future<bool> logOut() async {
    await _auth
        .signOut()
        .onError((error, stackTrace) => Get.snackbar('Error', '$error'));
    isLogin = false;
    _localStorageService.isLogin = null;
    userProfile = null;
    return true;
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
