import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task_manager_app/controllers/local_database_controller.dart';
import 'package:task_manager_app/models/user_model.dart';
import 'package:task_manager_app/services/components/loading.dart';
import 'package:task_manager_app/services/components/snack.dart';
import 'package:task_manager_app/services/firebase/firestore/user_services.dart';
import 'package:task_manager_app/views/home%20views/home_view.dart';

class AuthController extends GetxController {
  final GlobalKey<FormState> formSignUpKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formSignInKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formResetKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<User> _user = Rxn<User>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailResetController = TextEditingController();

  var isVisible = false.obs;
  var isChecked = false.obs;

  bool isLoading = true;

  String? email, password, name;

  String? get user => _user.value?.email;

  LocaleDatabaseController localeDatabaseController =
      LocaleDatabaseController();

  @override
  void onInit() async {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
    if (_auth.currentUser != null) {
      getUserData(_auth.currentUser!.uid);
    }
  }

  void toggleObscure() {
    isVisible.value = !isVisible.value;
  }

  Future emailAndPassSignIn() async {
    try {
      showProgressDialog();
      await _auth
          .signInWithEmailAndPassword(email: email!, password: password!)
          .then((value) {
        getUserData(value.user!.uid);
      });
      hideProgressDialog();
      Get.offAll(() => const HomeView());
    } catch (e) {
      log(e.toString());
      hideProgressDialog();
      showRedSnackBar('Email or password is incorrect');
    }
  }

  Future emailAndPassSignUp() async {
    try {
      showProgressDialog();
      await _auth
          .createUserWithEmailAndPassword(email: email!, password: password!)
          .then((user) => saveUser(user, false));
      hideProgressDialog();
      Get.offAll(() => const HomeView());
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      hideProgressDialog();
      showRedSnackBar(e.message.toString());
    } catch (e) {
      log(e.toString());
      hideProgressDialog();
      showRedSnackBar('Something went wrong, please try again');
    }
  }

  Future signInWithGoogle() async {
    try {
      showProgressDialog();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await _auth.signInWithCredential(credential).then((user) async {
        bool isUserExist = await getUserDataIfExist(user.user!.uid);
        if (!isUserExist) {
          saveUser(user, true);
        }
      });
      hideProgressDialog();
      Get.offAll(() => const HomeView());
    } catch (e) {
      log(e.toString());
      hideProgressDialog();
      showRedSnackBar('Something went wrong, please try again');
    }
  }

  Future saveUser(UserCredential user, bool googleSignIn) async {
    UserModel userModel = UserModel(
      id: user.user!.uid,
      name: googleSignIn ? user.user!.displayName ?? 'User Name' : name!,
      email: user.user!.email!,
    );
    await FireStoreUser().addUserToFireStore(userModel);
    await setUser(userModel);
  }

  Future setUser(UserModel userModel) async {
    await localeDatabaseController.setUser(userModel);
  }

  Future getUserData(String uid) async {
    await FireStoreUser().getCurrentUser(uid).then((value) async {
      await setUser(UserModel.fromJson(value!.data() as Map<String, dynamic>));
    });
  }

  Future<bool> getUserDataIfExist(String uid) async {
    DocumentSnapshot<Object?>? value =
        await FireStoreUser().getCurrentUser(uid);

    if (value!.exists) {
      await setUser(UserModel.fromJson(value.data() as Map<String, dynamic>));
      return true;
    } else {
      return false;
    }
  }

  Future updateUserData(UserModel userModel) async {
    await FireStoreUser()
        .updateUser(userModel.id, userModel.name)
        .then((value) async {
      await setUser(userModel);
    });
    update();
  }

  Future resetPassword() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailResetController.text.trim());
    emailResetController.clear();
    Get.back();
    showGreenSnackBar('Reset password mail sent successfully');
  }
}
