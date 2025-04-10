import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:task_manager_app/models/task_model.dart';
import 'package:task_manager_app/services/components/snack.dart';

class FirestoreService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  final CollectionReference tasksCollectionRef =
      FirebaseFirestore.instance.collection("tasks");

  Future<void> createTask(TaskModel task) async {
    try {
      final docRef = await tasksCollectionRef.add(task.toJson());
      final taskId = docRef.id;
      task.id = taskId;
      await docRef.update({'id': taskId});
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<TaskModel>> getTasksByUserId(String userId) async {
    List<TaskModel> tasks = [];
    try {
      QuerySnapshot querySnapshot =
          await tasksCollectionRef.where('userId', isEqualTo: userId).get();

      for (var doc in querySnapshot.docs) {
        tasks.add(TaskModel.fromJson(doc.data() as Map<String, dynamic>));
      }
    } catch (e) {
      log(e.toString());
    }
    return tasks;
  }

  Future<void> updateTaskToCompleted(String id) async {
    try {
      await tasksCollectionRef.doc(id).update(
        {'isCompleted': true},
      );
    } catch (e) {
      log(e.toString());
      showRedSnackBar('');
    }
  }

  Future<void> deleteTask(String id, List<String> files) async {
    try {
      await deleteFilesFromUrls(files);
      await tasksCollectionRef.doc(id).delete();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteFilesFromUrls(List<String> urls) async {
    for (String url in urls) {
      try {
        final ref = storage.refFromURL(url);
        await ref.delete();
      } catch (e) {
        log(e.toString());
      }
    }
  }

  Future<List<String>> uploadFiles(List<XFile> files) async {
    List<String> fileLinks = [];
    try {
      for (var file in files) {
        String filePath = 'task_files/${file.name}';
        UploadTask uploadTask = storage.ref(filePath).putFile(File(file.path));
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        fileLinks.add(downloadUrl);
      }
    } catch (e) {
      log(e.toString());
    }
    return fileLinks;
  }
}
