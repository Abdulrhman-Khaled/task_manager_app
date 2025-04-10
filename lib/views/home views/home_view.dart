import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';
import 'package:task_manager_app/controllers/home_controller.dart';
import 'package:task_manager_app/models/task_model.dart';

import 'package:task_manager_app/services/components/confirm_dialog.dart';
import 'package:task_manager_app/services/components/text_field.dart';
import 'package:task_manager_app/services/theme/colors.dart';
import 'package:task_manager_app/views/task%20views/add_task_view.dart';
import 'package:task_manager_app/views/task%20views/task_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Get.to(() => const AddTaskView());
              },
              backgroundColor: primary,
              label: Text('Add Task'),
              icon: Icon(Ionicons.add),
            ),
            body: controller.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: primary,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.user.name,
                                    style: TextStyle(
                                      color: primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    controller.user.email,
                                    style: TextStyle(
                                      color: darkGrey,
                                      fontSize: 12.sp,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  showConfirmDialog(
                                    context: context,
                                    title: 'Sign Out',
                                    message:
                                        'Are you sure you want to sign out?',
                                    onConfirm: () async {
                                      await controller.signOut();
                                    },
                                  );
                                },
                                icon: Icon(
                                  Ionicons.log_out_outline,
                                  color: red,
                                  size: 20.sp,
                                ))
                          ],
                        ),
                        Divider(height: 3.h),
                        AppTextField(
                          textFormController: controller.searchController,
                          width: double.infinity,
                          height: 70,
                          hintText: 'Search for a task...',
                          labelText: 'Search for a task...',
                          iconLead: Ionicons.search_outline,
                          labelFloating: FloatingLabelBehavior.never,
                          onChangeFunction: (query) {
                            controller.searchForTask(query);
                          },
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                ExpansionTile(
                                    title: Text(
                                        controller.isLoading
                                            ? 'Ongoing Tasks'
                                            : 'Ongoing Tasks (${controller.filteredTasks.where((t) => !t.isCompleted).length})',
                                        style: TextStyle(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.bold,
                                            color: primary)),
                                    initiallyExpanded: true,
                                    shape: Border(),
                                    tilePadding: EdgeInsets.zero,
                                    children: [
                                      controller.filteredTasks
                                              .where((t) => !t.isCompleted)
                                              .isEmpty
                                          ? Text('No ongoing tasks found',
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: darkGrey))
                                          : Wrap(
                                              spacing: 10,
                                              runSpacing: 10,
                                              children: controller.filteredTasks
                                                  .where((t) => !t.isCompleted)
                                                  .map((task) => taskCard(task))
                                                  .toList(),
                                            ),
                                    ]),
                                Divider(height: 3.h),
                                ExpansionTile(
                                  title: Text(
                                      controller.isLoading
                                          ? 'Completed Tasks'
                                          : 'Completed Tasks (${controller.filteredTasks.where((t) => t.isCompleted).length})',
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold,
                                          color: primary)),
                                  initiallyExpanded: false,
                                  shape: Border(),
                                  tilePadding: EdgeInsets.zero,
                                  children: [
                                    controller.filteredTasks
                                            .where((t) => t.isCompleted)
                                            .isEmpty
                                        ? Text('No completed tasks found',
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: darkGrey))
                                        : Wrap(
                                            spacing: 10,
                                            runSpacing: 10,
                                            children: controller.filteredTasks
                                                .where((t) => t.isCompleted)
                                                .map((task) => taskCard(task))
                                                .toList(),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          );
        });
  }

  Widget taskCard(TaskModel task) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        Get.to(() => TaskView(task: task));
      },
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: transparent,
            border: Border.all(color: primary),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(task.title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text(task.dueDate,
                          style: const TextStyle(color: darkGrey)),
                      const SizedBox(height: 2),
                      Text('${task.priority} priority',
                          style: TextStyle(
                              color: task.priority == 'High'
                                  ? red
                                  : task.priority == 'Medium'
                                      ? orange
                                      : green)),
                    ]),
              ),
              Icon(Ionicons.chevron_forward, color: primary)
            ],
          )),
    );
  }
}
