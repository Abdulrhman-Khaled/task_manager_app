// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';
import 'package:task_manager_app/controllers/auth_controller.dart';
import 'package:task_manager_app/services/components/buttons.dart';
import 'package:task_manager_app/services/components/text_field.dart';
import 'package:task_manager_app/services/theme/colors.dart';
import 'package:task_manager_app/views/auth%20views/sign_in_view.dart';

class SignUpView extends GetWidget<AuthController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Ionicons.chevron_back,
          ),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: primary),
        centerTitle: true,
        title: Text(
          'Sign Up',
          style: const TextStyle(fontSize: 22, color: primary),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
          top: 40,
          right: 20,
          left: 20,
        ),
        child: Form(
          key: controller.formSignUpKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Here We Go',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                      color: primary),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Create Your Account',
                  style: TextStyle(fontSize: 16, color: darkGrey),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              AppTextField(
                width: double.infinity,
                textType: TextInputType.name,
                iconLead: Ionicons.person_outline,
                hintText: 'Your Name',
                labelText: 'Name',
                onSave: (value) {
                  controller.name = value;
                },
              ),
              AppTextField(
                width: double.infinity,
                textType: TextInputType.emailAddress,
                iconLead: Ionicons.mail_outline,
                hintText: 'example@gmail.com',
                isEmailRegex: true,
                labelText: 'Email',
                onSave: (value) {
                  controller.email = value;
                },
              ),
              Obx(
                () => AppTextField(
                  width: double.infinity,
                  textType: TextInputType.visiblePassword,
                  iconLead: Ionicons.lock_closed_outline,
                  hintText: '••••••••••••••••••',
                  labelText: 'Password',
                  textFormController: controller.passwordController,
                  isLength: true,
                  isRegex: true,
                  needSuffix: true,
                  onSave: (value) {
                    controller.password = value;
                  },
                  isPassword: !controller.isVisible.value,
                  iconSuffix: controller.isVisible.value
                      ? Ionicons.eye_off_outline
                      : Ionicons.eye_outline,
                  function: () {
                    controller.toggleObscure();
                  },
                ),
              ),
              AppFilledButton(
                buttonText: 'Sign Up',
                height: 50,
                width: double.infinity,
                function: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  controller.formSignUpKey.currentState!.save();
                  if (controller.formSignUpKey.currentState!.validate()) {
                    await controller.emailAndPassSignUp();
                  }
                },
              ),
              SizedBox(
                height: 3.h,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'or you can continue with',
                  style: TextStyle(fontSize: 16, color: darkGrey),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              FloatingActionButton.extended(
                  heroTag: 'fab2',
                  onPressed: () async {
                    await controller.signInWithGoogle();
                  },
                  backgroundColor: Colors.white,
                  label: Text(
                    'continue using google',
                    style: TextStyle(color: primary),
                  ),
                  icon: Icon(
                    Ionicons.logo_google,
                    color: primary,
                  )),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(fontSize: 16, color: darkGrey),
                  ),
                  InkWell(
                    onTap: () {
                      Get.off(() => SignInView());
                    },
                    highlightColor: primary.withOpacity(0.3),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
