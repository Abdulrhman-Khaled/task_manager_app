import 'package:get/get.dart';
import 'package:task_manager_app/controllers/auth_controller.dart';
import 'package:task_manager_app/controllers/local_database_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(LocaleDatabaseController());
  }
}
