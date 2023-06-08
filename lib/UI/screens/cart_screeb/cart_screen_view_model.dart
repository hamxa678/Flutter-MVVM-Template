import 'package:dio/dio.dart';
import 'package:flutter_mvvm_template/core/enums/view_state.dart';
import 'package:flutter_mvvm_template/core/models/todos_model.dart';
import 'package:flutter_mvvm_template/core/others/base_view_model.dart';

class CartScreenViewModel extends BaseViewModel {
  CartScreenViewModel() {
    getTodos();
  }
  List<TodosModel> todos = [];
  int todosCount = 10;
  getTodos() async {
    setState(ViewState.busy);
    await Dio().get("https://jsonplaceholder.typicode.com/todos").then((value) {
      todos =
          value.data.map<TodosModel>((e) => TodosModel.fromJson(e)).toList();
      setState(ViewState.idle);
    });
  }

  add() {
    todosCount++;
    notifyListeners();
  }

  delete() {
    todosCount--;
    // todos.removeRange(todos.length - 20, todos.length);
    print(todosCount);
    // print(todos.length);
    notifyListeners();
  }
}
