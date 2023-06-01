import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/UI/screens/onboarding/onboarding_view_model.dart';
import 'package:flutter_mvvm_template/core/models/other_models/onboarding.dart';
import 'package:provider/provider.dart';

///
/// Flow logic is already done. Just need
/// to add the UI and UI Logic.
///

class OnboardingScreen extends StatefulWidget {
  final int currentIndex;
  final List<Onboarding> onboardingList;
  final List<Image> preCachedImages;
  const OnboardingScreen({
    Key? key,
    this.currentIndex = 0,
    required this.onboardingList,
    required this.preCachedImages,
  }) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('@onboardingScreen');
    return ChangeNotifierProvider(
      create: (context) =>
          // ignore: unnecessary_this
          OnboardingViewModel(widget.currentIndex, this.widget.onboardingList),
      child: Consumer<OnboardingViewModel>(
        builder: (context, model, child) => const SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Text("ONBOARDINGS"),
            ),
            // body: Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     CarouselSlider(
            //       items: List.generate(
            //         model.onboardingList.length,
            //         (index) => Container(
            //           margin: EdgeInsets.symmetric(horizontal: 5.w),
            //           width: MediaQuery.of(context).size.width + 200.w,
            //           height: 400.h,
            //           decoration: BoxDecoration(
            //             image: DecorationImage(
            //               image: widget
            //                   .preCachedImages[model.currentPageIndex].image,
            //               fit: BoxFit.cover,
            //             ),
            //           ),
            //         ),
            //       ),
            //       options: CarouselOptions(
            //         height: 400.h,
            //         aspectRatio: 0.9,
            //         initialPage: 0,
            //         viewportFraction: 0.8,
            //         enlargeCenterPage: true,
            //         scrollDirection: Axis.horizontal,
            //         pageSnapping: true,
            //         onPageChanged: (index, reason) {
            //           model.updatePage(index);
            //         },
            //       ),
            //     ),
            //     Padding(
            //       padding:
            //           EdgeInsets.symmetric(vertical: 50.h, horizontal: 50.w),
            //       child: Center(
            //         child: Text(
            //           "${model.onboardingList[model.currentPageIndex].title}",
            //           textAlign: TextAlign.center,
            //           style: textStyleWithRobotoFont,
            //         ),
            //       ),
            //     ),
            //     Padding(
            //       padding: EdgeInsets.symmetric(
            //         horizontal: 24.w,
            //       ),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Container(
            //             width: 70.w,
            //           ),
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: List.generate(
            //                 model.onboardingList.length,
            //                 (index) => StatusDot(
            //                     dotColor: index == model.currentPageIndex
            //                         ? primaryColor
            //                         : Colors.transparent)),
            //           ),
            //           _skipButton(model),
            //         ],
            //       ),
            //     )
            //   ],
            // ),
          ),
        ),
      ),
    );
  }

  // Widget _skipButton(OnboardingViewModel model) {
  //   return InkWell(
  //     onTap: () {
  //       model.updatePage(model.currentPageIndex + 1);
  //       Get.to(() => LoginScreen());
  //     },
  //     child: Container(
  //       padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 11.h),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(50),
  //         color: greyColor,
  //       ),
  //       child: Text("Skip",
  //           style: textStyleWithRobotoFont.copyWith(
  //               color: Colors.white, fontSize: ScreenUtil().setSp(16))),
  //     ),
  //   );
  // }
}
