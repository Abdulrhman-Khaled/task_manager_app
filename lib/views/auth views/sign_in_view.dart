import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';
import 'package:task_manager_app/controllers/auth_controller.dart';
import 'package:task_manager_app/services/components/appbar.dart';
import 'package:task_manager_app/services/components/buttons.dart';
import 'package:task_manager_app/services/components/text_field.dart';
import 'package:task_manager_app/services/theme/colors.dart';
import 'package:task_manager_app/views/auth%20views/sign_up_screen.dart';

class SignInView extends GetWidget<AuthController> {
  SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Sign In',
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
          top: 40,
          right: 20,
          left: 20,
        ),
        child: Form(
          key: controller.formSignInKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome Back',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: primary),
                ),
              ),
              SizedBox(height: 1.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sign in to your account',
                  style: TextStyle(fontSize: 16, color: darkGrey),
                ),
              ),
              SizedBox(
                height: 4.h,
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
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Get.defaultDialog(
                        title: 'Reset Password',
                        titleStyle: const TextStyle(color: primary),
                        contentPadding:
                            const EdgeInsets.fromLTRB(16, 16, 16, 5),
                        titlePadding: const EdgeInsets.only(top: 16),
                        content: Form(
                          key: controller.formResetKey,
                          child: Column(
                            children: [
                              Text(
                                'Enter your email address and we will send you a link to reset your password',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              AppTextField(
                                textFormController:
                                    controller.emailResetController,
                                width: double.infinity,
                                textType: TextInputType.emailAddress,
                                iconLead: Ionicons.mail_outline,
                                hintText: 'example@gmail.com',
                                labelText: 'Email',
                              ),
                              AppFilledButton(
                                width: double.infinity,
                                buttonColor: primary,
                                buttonText: 'Send Reset Mail',
                                function: () async {
                                  if (controller.formResetKey.currentState!
                                      .validate()) {
                                    await controller.resetPassword();
                                  }
                                },
                              ),
                            ],
                          ),
                        ));
                  },
                  highlightColor: primary.withOpacity(0.3),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 16,
                      color: primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AppFilledButton(
                buttonText: 'Sign In',
                height: 50,
                width: 100.w,
                function: () async {
                  if (controller.formSignInKey.currentState!.validate()) {
                    controller.formSignInKey.currentState!.save();
                    FocusManager.instance.primaryFocus?.unfocus();
                    await controller.emailAndPassSignIn();
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
                  heroTag: 'fab1',
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
                    'Don\'t have an account?',
                    style: TextStyle(fontSize: 11.sp, color: darkGrey),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  InkWell(
                    onTap: () {
                      Get.off(() => const SignUpView());
                    },
                    highlightColor: primary.withOpacity(0.3),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
