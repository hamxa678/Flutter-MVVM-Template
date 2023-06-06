import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/UI/custom_widget/dialogbox/auth_dialog.dart';
import 'package:flutter_mvvm_template/UI/screens/root/root_screen.dart';
import 'package:flutter_mvvm_template/core/enums/view_state.dart';
import 'package:flutter_mvvm_template/core/models/body/signup_body.dart';
import 'package:flutter_mvvm_template/core/others/base_view_model.dart';
import 'package:flutter_mvvm_template/core/services/firebase_auth_service.dart';
import 'package:flutter_mvvm_template/core/services/file_picker_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../locator.dart';

class SignUpViewModel extends BaseViewModel {
  /// Below line is used to get instance of our firebase auth service and file picker.
  final _firebaseAuthService = locator<FirebaseAuthService>();
  final _imagePickerService = locator<FilePickerService>();

  /// SignUp screen textfield controller
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  /// current date time for date picker initial date
  DateTime selectedDate = DateTime.now();

  /// SignUpBody model class object
  SignUpBody signUpBody = SignUpBody();

  /// form key for form validation
  final formKey = GlobalKey<FormState>();

  /// All menu items list for dropdown widget
  List<String> list = <String>['Male', 'Female', 'Other'];

  /// false for hiding password and true for showing password and false is default value
  bool isPasswordVisible = false;

  /// default gender is Male
  String? gender = "Male";

  /// below function is used to  toggle the dropdown value when user selects any value
  toggleDropDownValue(String value) {
    gender = value;
    notifyListeners();
  }

  ///  for toggling password visibility when user clicks on suffix icon
  togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  /// below function is used to select the date
  Future<void> selectDop(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dobController.text = DateFormat('dd-MM-yyyy').format(selectedDate);
    }
  }

  /// below function is used to request for sign up
  signUp() async {
    signUpBody.name = nameController.text;
    signUpBody.email = emailController.text;
    signUpBody.password = passwordController.text;
    signUpBody.location = locationController.text;
    signUpBody.dob = dobController.text;
    signUpBody.gender = gender;
    signUpBody.phone = phoneNoController.text;

    setState(ViewState.busy);
    bool response =
        await _firebaseAuthService.signupWithEmailAndPassword(signUpBody);
    if (response) {
      Get.offAll(const RootScreen());
    }
    setState(ViewState.idle);
  }

  /// below function is used to pick image from gallery
  pickImage() async {
    signUpBody.image = await _imagePickerService.pickImage();
    notifyListeners();
  }

  /// below function is used to dispose all the controllers
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    locationController.dispose();
    super.dispose();
  }
}
