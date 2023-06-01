import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/UI/screens/auth_signup/sign_up/sign_up_view_model.dart';
import 'package:flutter_mvvm_template/core/enums/view_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpViewModel(),
      child: Consumer<SignUpViewModel>(
        builder: (context, model, child) => ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          child: SafeArea(
            child: Scaffold(
              // backgroundColor: backgroundColor,
              body: Stack(
                children: [
                  Container(
                      // color: greyColor,
                      ),

                  ///
                  /// Column Contain app Bar And  User profile Image
                  ///
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ///
                        /// ========== This Section Contain Back Button And Avatar =============
                        ///

                        Container(
                          decoration: BoxDecoration(
                              // color: backgroundColor,
                              border: Border.all(
                                  color: Colors.transparent, width: 0.0)),
                          child: Column(
                            children: [
                              const SizedBox(height: 60),

                              ///
                              /// custom app bar
                              ///
                              // AuthenticationAppBar(
                              //   heading: "Sign Up",
                              // ),

                              ///
                              /// UserIcon
                              ///
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 60, bottom: 24),
                                child: Center(
                                  child: Stack(
                                    children: [
                                      /// User profile Avatar
                                      if (model.signUpBody.image != null)
                                        ClipRRect(
                                          child: Image.file(
                                            model.signUpBody.image!,
                                            height: 141,
                                            width: 141,
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(200),
                                        )
                                      else

                                      /// Add Image Icon
                                      Positioned(
                                        right: 05,
                                        top: 02,
                                        child: InkWell(
                                          onTap: () {
                                            debugPrint(
                                                'Pick Image button Clicked');
                                            model.pickImage();
                                          },
                                          child: Container(
                                            height: 30.h,
                                            width: 30.h,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF2E0A9),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: const Icon(
                                              Icons.add,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///
                        /// =============== This Section Contain Login Form ==============
                        ///

                        Stack(
                          children: [
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  // color: backgroundColor,
                                  border: Border.all(
                                      color: Colors.transparent, width: 0.0)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 35, horizontal: 31),
                              decoration: const BoxDecoration(
                                  // color: greyColor,
                                  borderRadius: BorderRadius.only(
                                topRight: Radius.circular(24),
                                topLeft: Radius.circular(24),
                              )),
                              child: Form(
                                key: _formKey,
                                child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    /// Contain Facebook, google, apple sign Button

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        // SocialAuthButtons(),
                                      ],
                                    ),

                                    const SizedBox(height: 23),



                                    const SizedBox(height: 24),

                                    /// Password field


                                    const SizedBox(height: 24),

                                    /// Email field


                                    const SizedBox(height: 24),

                                    /// location field


                                    const SizedBox(height: 16),

                                    /// Row Contain Is Remind radio button
                                   

                                    // Container(
                                    //   width: 147.w,
                                    //   height: 45.h,
                                    //   child: RectangularButton(
                                    //     radius: 15,
                                    //     text: "Sign Up",
                                    //     onPressed: () async {
                                    //       if (_formKey.currentState!
                                    //           .validate()) {
                                    //         _formKey.currentState!.save();
                                    //         model.requestSignUp();
                                    //       }
                                    //     },
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
