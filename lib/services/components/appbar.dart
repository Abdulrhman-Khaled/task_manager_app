import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:task_manager_app/services/theme/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Color iconColor;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.backgroundColor = transparent,
    this.iconColor = primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Ionicons.chevron_back),
      ),
      backgroundColor: backgroundColor,
      iconTheme: IconThemeData(color: iconColor),
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(fontSize: 22, color: primary),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
