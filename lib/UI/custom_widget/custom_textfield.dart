import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
      this.obscureText = false,
      this.controller,
      required this.hintText,
      // this.prefexIcon,
      // this.suffexIcon,
      this.onTap,
      this.enable = true,
      this.width = double.infinity,
      // this.hintStyle,
      this.onSaved,
      this.validator,
      this.height = 113,
      this.readOnly = false,
      this.keyboardtype,
      this.suffixIcon,
      this.counterText,
      this.maxLength})
      : super(key: key);
  final bool obscureText;
  final TextEditingController? controller;
  final String hintText;
  // final Widget? prefexIcon;
  // final Widget? suffexIcon;
  final VoidCallback? onTap;
  TextInputType? keyboardtype;
  final bool enable;
  final double? width;
  double height;
  final int? maxLength;
  bool readOnly;
  Widget? suffixIcon;
  String? counterText;

  // final TextStyle? hintStyle;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TextFormField(
        readOnly: readOnly,
        maxLength: maxLength,
        keyboardType: keyboardtype,
        validator: validator,
        onSaved: onSaved,
        enabled: enable,
        onTap: onTap,
        obscureText: obscureText,
        controller: controller,
        style: TextStyle(
          fontSize: 15.sp,
          color: const Color(0xff0D0F23),
        ),
        decoration: InputDecoration(
          counterText: counterText,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(60.r),
            borderSide: const BorderSide(color: Color(0xff707070)),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(60.r),
            borderSide: const BorderSide(color: Color(0xff707070)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(60.r),
            borderSide: const BorderSide(color: Color(0xff707070)),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          hintText: hintText,
          errorStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 8.sp,
            color: const Color(0xffFF0000),
          ),
          hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            fontSize: 15.sp,
            color: const Color(0xffA0A1B4),
          ),
          // prefixIcon: prefexIcon,
          // suffixIcon: suffexIcon,
        ),
      ),
    );
  }
}
