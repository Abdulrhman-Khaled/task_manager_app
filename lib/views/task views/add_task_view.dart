import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:open_file/open_file.dart';
import 'package:sizer/sizer.dart';
import 'package:task_manager_app/controllers/task_controller.dart';
import 'package:task_manager_app/services/components/appbar.dart';
import 'package:task_manager_app/services/components/buttons.dart';
import 'package:task_manager_app/services/components/snack.dart';
import 'package:task_manager_app/services/components/text_field.dart';
import 'package:task_manager_app/services/theme/colors.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskController>(
        init: TaskController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomAppBar(
              title: 'Add New Task',
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppTextField(
                        textFormController: controller.titleController,
                        labelText: 'Title',
                        hintText: 'Enter task title',
                        width: double.infinity,
                        iconLead: Ionicons.checkbox_outline),
                    AppTextField(
                        textFormController: controller.descriptionController,
                        labelText: 'Description',
                        hintText: 'Enter task description',
                        width: double.infinity,
                        iconLead: Ionicons.menu_outline),
                    AppTextField(
                        textFormController: controller.dueDateController,
                        labelText: 'Due Date',
                        hintText: 'Tap to select date',
                        width: double.infinity,
                        readOnly: true,
                        onTapFunction: () async {
                          DateTime? picked = await showDatePicker(
                            firstDate: DateTime.now(),
                            initialDate: DateTime.now(),
                            lastDate: DateTime(2050),
                            context: context,
                          );
                          if (picked != null) {
                            controller.dueDateController.text =
                                DateFormat('dd-MM-yyyy')
                                    .format(picked)
                                    .toString();
                            controller.update();
                          }
                        },
                        iconLead: Ionicons.calendar_number_outline),
                    Text(
                      'Choose Priority',
                      style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: primary),
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Radio(
                                  value: 'Low',
                                  groupValue: controller.priority,
                                  onChanged: (value) {
                                    controller.priority = value.toString();
                                    controller.update();
                                  }),
                              Expanded(
                                child: Text('Low'),
                              )
                            ],
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Radio(
                                  value: 'Medium',
                                  groupValue: controller.priority,
                                  onChanged: (value) {
                                    controller.priority = value.toString();
                                    controller.update();
                                  }),
                              Expanded(child: Text('Medium'))
                            ],
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Radio(
                                  value: 'High',
                                  groupValue: controller.priority,
                                  onChanged: (value) {
                                    controller.priority = value.toString();
                                    controller.update();
                                  }),
                              Expanded(child: Text('High'))
                            ],
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Text(
                          'Attach Files (${controller.files.length}/3)',
                          style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                              color: primary),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Ionicons.add_circle_outline,
                              color: primary, size: 20.sp),
                          onPressed: () {
                            if (controller.files.length < 3) {
                              controller.pickFile();
                            } else {
                              showRedSnackBar('Can\'t add more than 3 files');
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: controller.files
                          .map((file) => Stack(children: [
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
                                  child: controller.getFileType(file.path) ==
                                          'image'
                                      ? InkWell(
                                          child: Image.file(
                                            File(file.path),
                                            fit: BoxFit.cover,
                                          ),
                                          onTap: () {
                                            OpenFile.open(file.path);
                                          },
                                        )
                                      : IconButton(
                                          icon: Icon(
                                            Ionicons.document_text_outline,
                                            color: primary,
                                            size: 30.sp,
                                          ),
                                          onPressed: () {
                                            OpenFile.open(file.path);
                                          },
                                        ),
                                ),
                                Positioned(
                                  top: -10,
                                  right: -10,
                                  child: IconButton(
                                    icon: Icon(Ionicons.remove_circle,
                                        color: red, size: 16.sp),
                                    onPressed: () {
                                      controller.files.remove(file);
                                      controller.update();
                                    },
                                  ),
                                ),
                              ]))
                          .toList(),
                    ),
                    SizedBox(height: 2.h),
                    AppFilledButton(
                        buttonText: 'Add Task',
                        buttonColor: primary,
                        width: double.infinity,
                        function: () async {
                          if (controller.formKey.currentState!.validate()) {
                            await controller.addTask();
                          }
                        })
                  ],
                ),
              ),
            ),
          );
        });
  }
}
