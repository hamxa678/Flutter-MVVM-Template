import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/UI/custom_widget/custom_button.dart';
import 'package:flutter_mvvm_template/UI/custom_widget/custom_textfield.dart';
import 'package:flutter_mvvm_template/UI/screens/auth_signup/login/login_screen.dart';
import 'package:flutter_mvvm_template/UI/screens/auth_signup/sign_up/sign_up_view_model.dart';
import 'package:flutter_mvvm_template/core/constants/strings.dart';
import 'package:flutter_mvvm_template/core/enums/view_state.dart';
import 'package:flutter_mvvm_template/core/extensions/string_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final User? user;
  const SignUpScreen({Key? key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpViewModel(user),
      child: Consumer<SignUpViewModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(25.w, 65.h, 25.w, 25.h),
              child: Form(
                key: model.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      '${staticImage}logo.png',
                      cacheHeight: 449,
                      cacheWidth: 406,
                      height: 100.h,
                      width: 100.w,
                      fit: BoxFit.scaleDown,
                    ),
                    SizedBox(height: 50.h),
                    Text((user == null) ? 'Sign Up' : 'Add Details',
                        style: TextStyle(
                            fontSize: 35.sp, color: const Color(0xff2441A3))),
                    SizedBox(height: 30.h),
                    CustomTextField(
                      validator: (input) =>
                          input!.isValidEmail() ? null : "Invalid Email",
                      keyboardtype: TextInputType.emailAddress,
                      hintText: 'Email (i.e. johndoe@gmail.com)',
                      controller: model.emailController,
                    ),
                    SizedBox(height: 20.h),
                    if (user == null)
                      CustomTextField(
                        validator: (input) => input!.isValidPassword()
                            ? null
                            : "Must contain 8 (lower, upper case, digit, and special charachter) characters",
                        suffixIcon: GestureDetector(
                            onTap: () {
                              model.togglePasswordVisibility();
                            },
                            child: (model.isPasswordVisible)
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility)),
                        obscureText: !model.isPasswordVisible,
                        hintText: 'Password',
                        controller: model.passwordController,
                      ),
                    if (user == null) SizedBox(height: 20.h),
                    CustomTextField(
                      validator: (input) =>
                          input!.isValidUserName() ? null : "Invalid Name",
                      hintText: 'Name',
                      controller: model.nameController,
                    ),
                    SizedBox(height: 20.h),

                    CustomTextField(
                      validator: (input) {
                        if (input!.isEmpty) {
                          return "Please enter your location";
                        }
                        return null;
                      },
                      hintText: 'Location',
                      controller: model.locationController,
                    ),
                    SizedBox(height: 20.h),
                    _customDropDown(model),

                    SizedBox(height: 20.h),
                    CustomTextField(
                      validator: (input) =>
                          input!.isValidPhone() ? null : "Invalid Phone Number",
                      hintText: 'Phone Number',
                      controller: model.phoneNoController,
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your DOB";
                        } else if (value ==
                            DateFormat('dd-MM-yyyy').format(DateTime.now())) {
                          return "Please enter valid DOB";
                        }
                        return null;
                      },
                      readOnly: true,
                      onTap: () {
                        model.selectDop(context);
                      },
                      keyboardtype: TextInputType.datetime,

                      //validator: model.inputValidation.validateEmail,
                      onSaved: (dob) {
                        //model.loginBody.email = email;
                      },
                      controller: model.dobController,
                      hintText: "DOB (i.e. DD/MM/YYYY)",
                    ),
                    SizedBox(height: 30.h),

                    // 55.verticalSpace,
                    CustomButton(
                      titleWidget: !(model.state == ViewState.busy)
                          ? Text(
                              (user == null) ? 'Sign Up' : 'Add Details',
                              style: TextStyle(
                                  fontSize: 20.sp, color: Colors.white),
                            )
                          : const CircularProgressIndicator(
                              color: Colors.white),
                      onPressed: () async {
                        if (model.formKey.currentState!.validate()) {
                          // await model.login();
                          await model.signUp();
                        }
                      },
                    ),
                    SizedBox(height: 20.h),
                    if (user == null) _alreadyHaveAccount()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _alreadyHaveAccount() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Already have account? ',
          ),
          InkWell(
            onTap: () {
              Get.to(() => const LoginScreen());
            },
            child: const Text(
              'Login',
              style: TextStyle(color: Color(0xff2441A3)),
            ),
          ),
        ],
      ),
    );
  }

  Container _customDropDown(SignUpViewModel model) {
    return Container(
      height: 50.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60.r),
          border: Border.all(color: const Color(0xff707070))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: model.gender,
          elevation: 16,
          style: TextStyle(
            fontSize: 15.sp,
            color: const Color(0xff0D0F23),
          ),
          onChanged: (String? value) {
            model.toggleDropDownValue(value!);
          },
          items: model.list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
