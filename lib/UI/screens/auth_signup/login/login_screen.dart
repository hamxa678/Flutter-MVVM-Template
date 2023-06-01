import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/UI/screens/auth_signup/forget_password/forget_password_screen.dart';
import 'package:flutter_mvvm_template/UI/screens/auth_signup/login/login_view_model.dart';
import 'package:flutter_mvvm_template/UI/screens/auth_signup/sign_up/sign_up_screen.dart';
import 'package:flutter_mvvm_template/core/enums/view_state.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder: (context, model, child) => ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
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
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.white, width: 0.0)),
                          child: Column(
                            children: const [
                              SizedBox(height: 60),

                              ///
                              /// UserIcon
                              ///
                              Padding(
                                padding: EdgeInsets.only(top: 60, bottom: 24),
                                child: Center(
                                    child: FlutterLogo(
                                  size: 100,
                                )
                                    //  ImageContainer(
                                    //   height: 141,
                                    //   width: 141,
                                    //   assets: "assets/static_assets/avatar.png",
                                    //   radius: 0,
                                    // ),
                                    ),
                              ),
                            ],
                          ),
                        ),

                        ///
                        /// ========= Login Form Section =========
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

                                    ///
                                    /// user name field
                                    ///
 

                                    const SizedBox(height: 24),

                                    ///
                                    /// Password field
                                    ///


                                    const SizedBox(height: 16),

                                    ///
                                    /// Remember me radio buttons section
                                    ///
                                    Row(
                                      children: [
                                        // CustomSingleRadioButton(
                                        //   isSelected: model.isRememberMe,
                                        //   onPressed: {
                                        //     model.toggleIsRememberMe()
                                        //   },
                                        // ),
                                        // InkWell(
                                        //   onTap: () =>
                                        //       ,
                                        //   child: Padding(
                                        //     padding: const EdgeInsets.all(8.0),
                                        //     child: CustomSingleRadioButton(

                                        //     ),
                                        //   ),
                                        // ),
                                        // SizedBox(
                                        //   width: 6,
                                        // ),
                                        // Text(
                                        //   "Remember Me",
                                        //   style:
                                        //       textStyleWithHacenFont.copyWith(
                                        //           fontSize: 11,
                                        //           color: Colors.white),
                                        // ),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {
                                            Get.to(
                                                const ForgetPasswordScreen());
                                          },
                                          child: const Text(
                                            "Forget Password",
                                            // style:
                                            //     textStyleWithHacenFont.copyWith(
                                            //   fontSize: 11,
                                            //   decoration:
                                            //       TextDecoration.underline,
                                            // ),
                                          ),
                                        )
                                      ],
                                    ),

                                    const SizedBox(height: 8),

                                    ///
                                    /// Register Button
                                    ///

                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(SignUpScreen());
                                        },
                                        child: const Text(
                                          "Register",
                                          // style:
                                          //     textStyleWithHacenFont.copyWith(
                                          //   fontSize: 11,
                                          //   decoration:
                                          //       TextDecoration.underline,
                                          // ),
                                        ),
                                      ),
                                    ),

//                                     Container(
//                                       width: 147.w,
// //                                    height: 45.h,
//                                       padding: EdgeInsets.only(top: 100),
//                                       child: RectangularButton(
//                                           height: 45.h,
//                                           radius: 14,
//                                           text: "Login",
//                                           onPressed: () async {
//                                             if (_formKey.currentState!
//                                                 .validate()) {
//                                               _formKey.currentState!.save();
//                                               await model.requestLogin();
//                                               if (!model.response.success) {
//                                                 Get.dialog(
//                                                   AlertDialog(
//                                                     title: Text("Failed"),
//                                                     content: Text(
//                                                         "${model.response.error}"),
//                                                     actions: [
//                                                       ElevatedButton(
//                                                         onPressed: () {
//                                                           Navigator.pop(
//                                                               context);
//                                                         },
//                                                         child: Text("Ok"),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 );
//                                               } else {
//                                                 Get.offAll(AppDrawer(
//                                                   child: RootScreen(),
//                                                 ));
//                                               }
//                                             }
// //                                        Get.offAll(AppDrawer(
// //                                          child: RootScreen(),
// //                                        ));
//                                           }),
//                                     ),
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
