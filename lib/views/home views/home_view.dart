import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/controllers/local_database_controller.dart';
import 'package:task_manager_app/services/components/buttons.dart';
import 'package:task_manager_app/services/components/loading.dart';
import 'package:task_manager_app/views/auth%20views/welcome_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  Future<void> signOut() async {
    showProgressDialog();
    await FirebaseAuth.instance.signOut();
    await Get.find<LocaleDatabaseController>().deleteUser();
    hideProgressDialog();
    Get.offAll(() => const WelcomeView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppFilledButton(
              buttonText: 'Sign Out',
              function: () async {
                await signOut();
              },
            )
          ],
        ),
      ),
    );
  }
}
