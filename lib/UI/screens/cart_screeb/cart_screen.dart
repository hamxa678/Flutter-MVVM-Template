import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/UI/screens/cart_screeb/cart_screen_view_model.dart';
import 'package:flutter_mvvm_template/core/enums/view_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  //   int? userId;
  // int? id;
  // String? title;
  // bool? completed;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartScreenViewModel>(builder: (context, model, child) {
      return ModalProgressHUD(
        inAsyncCall: model.state == ViewState.busy,
        progressIndicator: const CircularProgressIndicator(
          color: Colors.red,
        ),
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Cart'),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  (model.todosCount > 0) ? model.delete() : null;
                },
                child: const Icon(Icons.exposure_minus_1)),
            body: ListView.builder(
              itemCount: model.todos.length,
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) => ListTile(
                title: Text(model.todos[index].title!),
                subtitle: Text(model.todos[index].id.toString()),
                trailing: (model.todos[index].completed!)
                    ? Text(
                        "Completed",
                        style: TextStyle(fontSize: 10.sp, color: Colors.green),
                      )
                    : Text(
                        "Incompleted",
                        style: TextStyle(fontSize: 10.sp, color: Colors.red),
                      ),
              ),
            )),
      );
    });
  }
}
