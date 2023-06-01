import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestFailedDialog extends StatelessWidget {
  final String errorMessage;

  const RequestFailedDialog({Key? key, required this.errorMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('requestFailedTitle'.tr),
      content: Text(errorMessage),
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
