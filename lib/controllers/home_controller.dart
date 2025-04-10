import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controllers/local_database_controller.dart';
import 'package:task_manager_app/models/task_model.dart';
import 'package:task_manager_app/models/user_model.dart';
import 'package:task_manager_app/services/components/loading.dart';
import 'package:task_manager_app/services/components/snack.dart';
import 'package:task_manager_app/views/auth%20views/welcome_view.dart';

class HomeController extends GetxController {
  TextEditingController searchController = TextEditingController();

  List<TaskModel> tasks = [];
  List<TaskModel> filteredTasks = [];

  bool isLoading = true;
  UserModel user = Get.find<LocaleDatabaseController>().getUserDetails();

  @override
  void onInit() async {
    super.onInit();
    await getAllUserTasks();
  }

  Future<void> getAllUserTasks() async {
    try {
      FirebaseFirestore.instance
          .collection('tasks')
          .where('userId',
              isEqualTo: Get.find<LocaleDatabaseController>().getUser!.id)
          .snapshots()
          .listen((snapshot) {
        tasks = snapshot.docs.map((doc) {
          return TaskModel.fromJson(doc.data());
        }).toList();
        filteredTasks = List.of(tasks);
        isLoading = false;
        update();
      });
    } catch (e) {
      log(e.toString());
      isLoading = false;
      update();
      showRedSnackBar('Something went wrong, please try again');
    }
  }

  Future<void> signOut() async {
    showProgressDialog();
    await FirebaseAuth.instance.signOut();
    await Get.find<LocaleDatabaseController>().deleteUser();
    hideProgressDialog();
    Get.offAll(() => const WelcomeView());
  }

  searchForTask(String query) {
    filteredTasks = tasks
        .where((task) =>
            task.title.contains(query) || task.description.contains(query))
        .toList();
    update();
  }
}
