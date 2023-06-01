import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/core/constants/colors.dart';
import 'package:flutter_mvvm_template/core/enums/view_state.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'forget_password_view_model.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ForgetPasswordScreenViewModel(),
      child: Consumer<ForgetPasswordScreenViewModel>(
        builder: (context, model, child) => ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          child: const SafeArea(
            child: Scaffold(
              backgroundColor: scaffoldBackgroundColor,
//               body: Stack(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 60),
//                     child: AuthenticationAppBar(
//                       heading: "Forget Password",
//                     ),
//                   ),
//                   Column(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           margin: EdgeInsets.only(top: 160),
//                           padding: EdgeInsets.only(left: 31, right: 31),
//                           decoration: BoxDecoration(
//                               color: greyColor,
//                               borderRadius: BorderRadius.only(
//                                 topRight: Radius.circular(24),
//                                 topLeft: Radius.circular(24),
//                               )),
//                           child: SingleChildScrollView(
//                             child: Form(
//                               key: _formKey,
//                               child: Column(
// //                        physics: BouncingScrollPhysics(),
//                                 children: [
//                                   SizedBox(
//                                     height: 60.h,
//                                   ),

//                                   Center(
//                                     child: Text(
//                                       "Forget your Passwords?",
//                                       style: textStyleWithHacenFont.copyWith(
//                                         fontSize: 23.sp,
//                                         decoration: TextDecoration.underline,
//                                       ),
//                                     ),
//                                   ),

//                                   SizedBox(
//                                     height: 26.h,
//                                   ),

//                                   Text(
//                                     "Enter your registered email below to receive password reset instructions",
//                                     textAlign: TextAlign.center,
//                                     style: textStyleWithHacenFont.copyWith(
//                                         fontSize: ScreenUtil().setSp(17),
//                                         color: Colors.white),
//                                   ),

//                                   Padding(
//                                     padding:
//                                         EdgeInsets.only(top: 26, bottom: 60),
//                                     child: ImageContainer(
//                                       width: 233,
//                                       height: 183,
//                                       assets:
//                                           "${staticAssetsPath}mobile_graghic.png",
//                                       radius: 0,
//                                       fit: BoxFit.contain,
//                                     ),
//                                   ),

//                                   /// Email field
//                                   CustomTextField(
//                                     controller: model.emailController,
//                                     onTap: () {},
//                                     validator: (val) {
//                                       if (!EmailValidator.validate(val)) {
//                                         return 'Please Enter Your Valid Email';
//                                       } else {
//                                         return null;
//                                       }
//                                     },
//                                     onSaved: (val) {
//                                       model.resetPasswordBody.email = val;
//                                     },
//                                     hintText: "Email",
//                                     prefixIcon: ImageContainer(
//                                       width: 22.w,
//                                       height: 22.h,
//                                       assets:
//                                           "${staticAssetsPath}mail_field_icon.png",
//                                       fit: BoxFit.contain,
//                                     ),
//                                   ),

//                                   SizedBox(
//                                     height: 31,
//                                   ),

//                                   RectangularButton(
//                                     width: 147.w,
//                                     height: 45.h,
//                                     radius: 15,
//                                     text: "Send",
//                                     onPressed: () async {
//                                       if (_formKey.currentState!.validate()) {
//                                         _formKey.currentState!.save();
//                                         model.resetPassword();
//                                       }
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
            ),
          ),
        ),
      ),
    );
  }
}
