import 'package:flutter/material.dart';

import 'package:task_manager_app/services/theme/colors.dart';

Widget notFound() {
  return Container(
    alignment: Alignment.center,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.search_off_outlined, color: primary, size: 60),
        SizedBox(height: 10),
        Text('No Data Found',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
      ],
    ),
  );
}
