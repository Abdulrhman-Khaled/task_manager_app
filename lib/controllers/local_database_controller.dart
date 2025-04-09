import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_manager_app/models/user_model.dart';

class LocaleDatabaseController extends GetxController {
  final _getStorage = GetStorage();

  UserModel? get getUser {
    try {
      UserModel userModel = getUserDetails();
      return userModel;
    } catch (e) {
      return null;
    }
  }

  setUser(UserModel userModel) async {
    await _getStorage.write('user', jsonEncode(userModel.toJson()));
    await _getStorage.write('guest', false);
  }

  getUserDetails() {
    var user = _getStorage.read('user');
    return UserModel.fromJson(jsonDecode(user!));
  }

  getGuest() {
    bool guest = _getStorage.read('guest') ?? true;
    return guest;
  }

  deleteUser() async {
    await _getStorage.remove('user');
    await _getStorage.write('guest', true);
  }
}
