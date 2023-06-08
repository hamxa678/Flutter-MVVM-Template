import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/core/enums/view_state.dart';
import 'package:flutter_mvvm_template/core/others/base_view_model.dart';

import '../cart_screeb/cart_screen_view_model.dart';

class RootScreenViewModel extends BaseViewModel {
  late CartScreenViewModel cartmodel;
  RootScreenViewModel() {
    // Timer.periodic(const Duration(milliseconds: 100), (timer) {
    //   // print(timer);
    //   setCounter();
    // });
  }

  add() {
    cartmodel.todosCount++;
    notifyListeners();
  }

  void update(CartScreenViewModel myModel) {
    cartmodel = myModel;
    notifyListeners();
  }

  List<Widget> allScreen = [
    // AppDrawer(child: DashboardScreen()),
    // MyCardScreen(),
    // CategoryScreen(enableBackButton: false),
    // ProfileScreen()
  ];
  int selectedScreen = 0;

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
