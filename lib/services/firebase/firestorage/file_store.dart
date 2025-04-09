import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class FirebaseStorageUploader {
   Future<String> uploadFileToFirebaseStorage(
      String image, String directory) async {
    final fileName = path.basename(image);

    Uint8List imageData = await XFile(image).readAsBytes();

    Reference storageRef =
        FirebaseStorage.instance.ref().child("$directory/$fileName");

    UploadTask uploadTask = storageRef.putData(imageData);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}
