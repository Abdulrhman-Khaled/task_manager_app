import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:task_manager_app/controllers/local_database_controller.dart';
import 'package:task_manager_app/models/task_model.dart';
import 'package:task_manager_app/services/components/loading.dart';
import 'package:task_manager_app/services/components/snack.dart';
import 'package:task_manager_app/services/firebase/firestore/task_services.dart';

class TaskController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String priority = 'Low';
  bool isCompleted = false;

  List<String> filesLinks = [];
  List<XFile> files = [];

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      compressionQuality: 50,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      files.add(XFile(file.path));
      update();
    }
  }

  String getFileType(String filePath) {
    String fileEx = p.extension(filePath).toLowerCase();
    if (['.jpg', '.jpeg', '.png'].contains(fileEx)) {
      return 'image';
    } else {
      return 'doc';
    }
  }

  Future addTask() async {
    try {
      showProgressDialog();
      await FirestoreService().uploadFiles(files).then((value) async {
        filesLinks = value;
        await FirestoreService().createTask(
          TaskModel(
            userId: Get.find<LocaleDatabaseController>().getUser!.id,
            title: titleController.text.trim(),
            description: descriptionController.text.trim(),
            dueDate: dueDateController.text.trim(),
            priority: priority,
            isCompleted: isCompleted,
            filesLinks: filesLinks,
          ),
        );
        hideProgressDialog();
        Get.back();
        showGreenSnackBar('Task added successfully');
      });
    } catch (e) {
      log(e.toString());
      hideProgressDialog();
      showRedSnackBar('Something went wrong, please try again');
    }
  }

  Future deleteTask(TaskModel task) async {
    try {
      Get.back();
      showProgressDialog();
      await FirestoreService().deleteTask(task.id!, task.filesLinks);
      hideProgressDialog();
      Get.back();
      showGreenSnackBar('Task deleted successfully');
    } catch (e) {
      log(e.toString());
      hideProgressDialog();
      showRedSnackBar('Something went wrong, please try again');
    }
  }

  Future markTaskAsCompleted(String taskId) async {
    try {
      Get.back();
      showProgressDialog();
      await FirestoreService().updateTaskToCompleted(taskId);
      hideProgressDialog();
      Get.back();
      showGreenSnackBar('Task updated successfully');
    } catch (e) {
      log(e.toString());
      hideProgressDialog();
      showRedSnackBar('Something went wrong, please try again');
    }
  }
}
