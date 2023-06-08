import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/UI/screens/cart_screeb/cart_screen_view_model.dart';
import 'package:flutter_mvvm_template/UI/screens/splash_screen.dart';
import 'package:flutter_mvvm_template/core/services/localization_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  final String title;

  // Design width and height: you can edit them as per your required design
  static const double _designWidth = 375;
  static const double _designHeight = 812;

  const MyApp({required this.title, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    /// Initialize the screen util, this will make your UI responsive.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartScreenViewModel>(
            create: (context) => CartScreenViewModel()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(_designWidth, _designHeight),
        builder: (context, widget) => GetMaterialApp(
          translations: LocalizationService(),
          locale: const Locale("en"),
          title: title,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
