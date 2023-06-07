import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/core/enums/view_state.dart';
import 'package:flutter_mvvm_template/core/others/base_view_model.dart';

class RootScreenViewModel extends BaseViewModel {
  int count = 1;

  RootScreenViewModel() {
    // Timer.periodic(const Duration(milliseconds: 100), (timer) {
    //   // print(timer);
    //   setCounter();
    // });
  }

  List<Widget> allScreen = [
    // AppDrawer(child: DashboardScreen()),
    // MyCardScreen(),
    // CategoryScreen(enableBackButton: false),
    // ProfileScreen()
  ];
  int selectedScreen = 0;

  setCounter() {
    count++;

    notifyListeners();
  }

  bool isEnableBottomBar = true;

  updatedScreenIndex(int index) {
    setState(ViewState.busy);
    selectedScreen = index;
    setState(ViewState.idle);
  }

  updateBottomBarStatus(bool val) {
    isEnableBottomBar = val;
    notifyListeners();
  }
}
