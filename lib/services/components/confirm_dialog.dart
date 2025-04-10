import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/services/components/buttons.dart';
import 'package:task_manager_app/services/theme/colors.dart';

class CustomConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;

  const CustomConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title,
          style: const TextStyle(color: primary, fontWeight: FontWeight.bold)),
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: AppFilledButton(
                buttonText: 'Cancel',
                buttonColor: red,
                textSize: 14,
                function: () {
                  Get.back();
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AppFilledButton(
                buttonText: 'Confirm',
                buttonColor: primary,
                textSize: 14,
                function: () {
                  onConfirm();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

showConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  required VoidCallback onConfirm,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomConfirmDialog(
        title: title,
        message: message,
        onConfirm: onConfirm,
      );
    },
  );
}
