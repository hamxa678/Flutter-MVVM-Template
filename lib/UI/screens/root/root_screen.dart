import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/UI/screens/root/root_screen_view_model.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RootScreenViewModel(),
      child: Consumer<RootScreenViewModel>(
        builder: (context, model, child) => WillPopScope(
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
          ),
        ),
      ),
    );
  }
}
