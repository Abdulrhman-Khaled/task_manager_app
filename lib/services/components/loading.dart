import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:sizer/sizer.dart';
import 'package:task_manager_app/services/theme/colors.dart';

SimpleFontelicoProgressDialog? progressDialog =
    SimpleFontelicoProgressDialog(context: Get.context!);
    
showProgressDialog() {
  progressDialog!.show(
      message: 'Loading...',
      indicatorColor: primary,
      backgroundColor: white,
      textStyle: TextStyle(fontSize: 12.sp));
}

hideProgressDialog() {
  progressDialog!.hide();
}
