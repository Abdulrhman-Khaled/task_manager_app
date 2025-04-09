import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:task_manager_app/services/components/buttons.dart';
import 'package:task_manager_app/services/theme/colors.dart';
import 'package:task_manager_app/views/auth%20views/sign_in_view.dart';
import 'package:task_manager_app/views/auth%20views/sign_up_screen.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              primary.withOpacity(0.8),
              white,
              white,
              white,
            ])),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/welcome.png',
                  height: 35.h,
                  colorBlendMode: BlendMode.multiply,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'Managing Your Tasks Easier',
                  style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Stay organized and boost productivity with our intuitive and simple task manager app',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: black, fontSize: 16),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AppFilledButton(
                        buttonText: 'Sign In',
                        function: () => Get.to(() => SignInView()),
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Expanded(
                      child: AppFilledButton(
                        buttonText: 'Register',
                        function: () => Get.to(() => SignUpView()),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
