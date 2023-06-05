import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/UI/custom_widget/custom_button.dart';
import 'package:flutter_mvvm_template/UI/custom_widget/custom_textfield.dart';
import 'package:flutter_mvvm_template/UI/screens/auth_signup/sign_up/sign_up_view_model.dart';
import 'package:flutter_mvvm_template/core/constants/strings.dart';
import 'package:flutter_mvvm_template/core/enums/view_state.dart';
import 'package:flutter_mvvm_template/core/extensions/string_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpViewModel(),
      child: Consumer<SignUpViewModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(25.w, 65.h, 25.w, 0),
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
                    Text('Login',
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
                    SizedBox(height: 20.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          // Get.to(ForgetPassword());
                        },
                        child: const Text(
                          'Forget password?',
                          style: TextStyle(color: Color(0xff2441A3)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    // 55.verticalSpace,
                    CustomButton(
                      titleWidget: !(model.state == ViewState.busy)
                          ? Text(
                              'Log in',
                              style: TextStyle(
                                  fontSize: 20.sp, color: Colors.white),
                            )
                          : const CircularProgressIndicator(
                              color: Colors.white),
                      onPressed: () async {
                        if (model.formKey.currentState!.validate()) {
                          // await model.login();
                        }
                      },
                    ),
                    SizedBox(height: 20.h),
                    // _dontHaveAccount()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
