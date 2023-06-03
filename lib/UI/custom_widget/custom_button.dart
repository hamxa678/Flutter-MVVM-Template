import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      this.titleWidget,
      this.width = double.infinity,
      this.onPressed});
  Widget? titleWidget;
  Widget? buttonWidget;
  double? width;
  VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          height: 60.h,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60.r),
              gradient: const LinearGradient(
                  colors: [Color(0xff174096), Color(0xff2C9E9E)])),
          child: Center(child: titleWidget)),
    );
  }
}
