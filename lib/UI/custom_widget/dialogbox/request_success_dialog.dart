import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestSuccessDialog extends StatelessWidget {
  final String successMsg;

  const RequestSuccessDialog({Key? key, required this.successMsg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('requestSuccessTitle'.tr),
      content: Text(successMsg),
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
