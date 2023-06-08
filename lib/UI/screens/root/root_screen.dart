import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/UI/screens/cart_screeb/cart_screen.dart';
import 'package:flutter_mvvm_template/UI/screens/cart_screeb/cart_screen_view_model.dart';
import 'package:flutter_mvvm_template/UI/screens/root/root_screen_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartScreenViewModel,
        RootScreenViewModel>(
      create: (context) => RootScreenViewModel(),
      update: (_, cartScreenViewModel, rootScreenViewModel) =>
          rootScreenViewModel!..update(cartScreenViewModel),
      child: Consumer<RootScreenViewModel>(builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () async {
            final status = await Get.dialog(AlertDialog(
              title: const Text('Caution!'),
              content:
                  const Text('Do you really want to close the application?'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Get.back(result: true);
                  },
                  child: const Text('Yes'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back(result: false);
                  },
                  child: const Text('No'),
                ),
              ],
            ));

            return status;
          },
          child: Scaffold(
              extendBody: true,
              floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    context.read<CartScreenViewModel>().add();
                    // model.add();
                  },
                  child: const Icon(Icons.exposure_plus_1)),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (model.cartmodel.todosCount == 0)
                        ? const Text(
                            'No more todos',
                            style: TextStyle(color: Colors.red),
                          )
                        : Text(
                            //model.cartmodel.todos.length

                            'Number of todos are ${context.read<CartScreenViewModel>().todosCount}',
                            style: const TextStyle(color: Colors.green),
                          ),
                    20.verticalSpace,
                    ElevatedButton(
                      child: const Text('Get todos'),
                      onPressed: () {
                        Get.to(const CartScreen());
                      },
                    ),
                  ],
                ),
              )),
          // body:
          // model.allScreen[model.selectedScreen],
          // bottomNavigationBar: model.isEnableBottomBar
          //     ? FABBottomAppBar(
          //         color: Colors.grey,
          //         backgroundColor: Colors.grey,
          //         selectedColor: primaryColor,
          //         notchedShape: const CircularNotchedRectangle(),
          //         onTabSelected: model.updatedScreenIndex,
          //         items: [],
          //       )
          //     : Container(),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerDocked,
          // floatingActionButton: model.isEnableBottomBar
          //     ? FloatingActionButton(
          //         backgroundColor: otherColor,
          //         onPressed: () {},
          //         child: const Icon(Icons.add),
          //         elevation: 2.0,
          //       )
          //     : Container(),
        );
      }),
    );
  }
}
