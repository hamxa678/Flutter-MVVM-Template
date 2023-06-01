import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthDialog extends StatelessWidget {
  final String message;
  final String title;

  const AuthDialog({Key? key, required this.title, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('ok'.tr),
        ),
      ],
    );
  }
}
