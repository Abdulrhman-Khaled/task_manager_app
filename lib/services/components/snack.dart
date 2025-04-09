import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/services/theme/colors.dart';

showGreenSnackBar(String body) {
  Get.snackbar('Success', body,
      margin: const EdgeInsets.all(10),
      duration: const Duration(milliseconds: 900),
      backgroundColor: green,
      colorText: white,
      snackPosition: SnackPosition.BOTTOM);
}

showRedSnackBar(String body) {
  Get.snackbar('Error', body,
      margin: const EdgeInsets.all(10),
      duration: const Duration(milliseconds: 900),
      backgroundColor: red,
      colorText: white,
      snackPosition: SnackPosition.BOTTOM);
}

showCustomSnackBar(String head, String body, Color color) {
  Get.snackbar(head, body,
      duration: const Duration(milliseconds: 900),
      margin: const EdgeInsets.all(10),
      backgroundColor: color,
      colorText: white,
      snackPosition: SnackPosition.BOTTOM);
}
