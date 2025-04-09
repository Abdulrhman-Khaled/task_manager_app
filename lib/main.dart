import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:task_manager_app/controllers/local_database_controller.dart';
import 'package:task_manager_app/firebase_options.dart';
import 'package:task_manager_app/services/theme/theme.dart';
import 'package:task_manager_app/services/utils/binding.dart';
import 'package:task_manager_app/views/auth%20views/welcome_view.dart';
import 'package:task_manager_app/views/home%20views/home_view.dart';

Future<void> main() async {
  setSystemChrome();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: 'Task Manager',
        debugShowCheckedModeBanner: false,
        initialBinding: Binding(),
        theme: appTheme,
        home: Get.put(LocaleDatabaseController()).getUser != null
            ? const HomeView()
            : const WelcomeView(),
      );
    });
  }
}
