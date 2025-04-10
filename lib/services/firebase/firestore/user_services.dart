import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager_app/models/user_model.dart';

class FireStoreUser {
  final CollectionReference userCollectionRef =
      FirebaseFirestore.instance.collection("users");

  Future<void> addUserToFireStore(UserModel userModel) async {
    try {
      return await userCollectionRef.doc(userModel.id).set(userModel.toJson());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<DocumentSnapshot?> getCurrentUser(String userId) async {
    try {
      return await userCollectionRef.doc(userId).get();
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<void> updateUser(
    String userId,
    String name,
  ) async {
    try {
      await userCollectionRef.doc(userId).update({
        'name': name,
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
