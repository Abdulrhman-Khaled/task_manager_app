import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';
import 'package:task_manager_app/controllers/task_controller.dart';
import 'package:task_manager_app/models/task_model.dart';
import 'package:task_manager_app/services/components/appbar.dart';
import 'package:task_manager_app/services/components/buttons.dart';
import 'package:task_manager_app/services/components/confirm_dialog.dart';
import 'package:task_manager_app/services/components/snack.dart';
import 'package:task_manager_app/services/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskView extends StatelessWidget {
  TaskModel task;
  TaskView({required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskController>(
        init: TaskController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomAppBar(title: 'Task Details'),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: transparent,
                      border: Border.all(color: primary),
                    ),
                    child: ListTile(
                      title: Text('Task Title'),
                      subtitle:
                          Text(task.title, overflow: TextOverflow.ellipsis),
                      subtitleTextStyle: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: primary,
                      ),
                      titleTextStyle: TextStyle(
                        fontSize: 10.sp,
                        color: darkGrey,
                      ),
                      leading: Icon(
                        Ionicons.checkbox_outline,
                        color: primary,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: transparent,
                      border: Border.all(color: primary),
                    ),
                    child: ListTile(
                      title: Text('Task Description'),
                      subtitle: Text(task.description,
                          maxLines: 2, overflow: TextOverflow.ellipsis),
                      subtitleTextStyle: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: primary,
                      ),
                      titleTextStyle: TextStyle(
                        fontSize: 10.sp,
                        color: darkGrey,
                      ),
                      leading: Icon(
                        Ionicons.menu_outline,
                        color: primary,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: transparent,
                      border: Border.all(color: primary),
                    ),
                    child: ListTile(
                      title: Text('Task Due Date'),
                      subtitle:
                          Text(task.dueDate, overflow: TextOverflow.ellipsis),
                      subtitleTextStyle: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: primary,
                      ),
                      titleTextStyle: TextStyle(
                        fontSize: 10.sp,
                        color: darkGrey,
                      ),
                      leading: Icon(
                        Ionicons.calendar_number_outline,
                        color: primary,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: transparent,
                      border: Border.all(color: primary),
                    ),
                    child: ListTile(
                      title: Text('Task Priority'),
                      subtitle:
                          Text(task.priority, overflow: TextOverflow.ellipsis),
                      subtitleTextStyle: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: task.priority == 'High'
                            ? red
                            : task.priority == 'Medium'
                                ? orange
                                : green,
                      ),
                      titleTextStyle: TextStyle(
                        fontSize: 10.sp,
                        color: darkGrey,
                      ),
                      leading: Icon(
                        Ionicons.swap_vertical_outline,
                        color: primary,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  if (task.filesLinks.isNotEmpty) ...[
                    Text(
                      'Attached Files (${task.filesLinks.length})',
                      style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: primary),
                    ),
                    SizedBox(height: 1.h),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: task.filesLinks
                          .map((link) => Stack(children: [
                                Container(
                                    width: 100,
                                    height: 100,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: transparent,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: primary,
                                        )),
                                    child: InkWell(
                                      child: Image.network(
                                        link,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(
                                            Ionicons.document_text_outline,
                                            color: primary,
                                            size: 30.sp,
                                          );
                                        },
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        },
                                      ),
                                      onTap: () async {
                                        if (!await launchUrl(Uri.parse(link))) {
                                          showRedSnackBar(
                                              'Could not open file, please try again');
                                        }
                                      },
                                    )),
                              ]))
                          .toList(),
                    ),
                  ],
                  SizedBox(height: 2.h),
                  if (!task.isCompleted) ...[
                    AppFilledButton(
                        buttonText: 'Mark As Completed',
                        buttonColor: green,
                        width: double.infinity,
                        function: () async {
                          showConfirmDialog(
                              context: context,
                              title: 'Complete Task',
                              message:
                                  'Are you sure you want to mark this task as completed?',
                              onConfirm: () async {
                                await controller.markTaskAsCompleted(task.id!);
                              });
                        }),
                    SizedBox(height: 2.h),
                  ],
                  AppOutlineButton(
                      buttonText: 'Delete Task',
                      buttonColor: red,
                      buttonTextColor: red,
                      width: double.infinity,
                      function: () async {
                        showConfirmDialog(
                            context: context,
                            title: 'Delete Task',
                            message:
                                'Are you sure you want to delete this task?',
                            onConfirm: () async {
                              await controller.deleteTask(task);
                            });
                      }),
                ],
              ),
            ),
          );
        });
  }
}
