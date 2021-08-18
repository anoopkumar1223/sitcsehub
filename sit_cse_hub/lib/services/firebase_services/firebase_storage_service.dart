import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class MyFirebaseStorage {
  static Future uploadFile(String destination, File file) async {
    try {
      UploadTask task;
      Reference ref = FirebaseStorage.instance.ref().child(destination);
      final metadata = SettableMetadata(
          contentType: 'application/pdf',
          customMetadata: {'picked-file-path': file.path});
      task = ref.putFile(File(file.path), metadata);
      String fileUrl = await (await task).ref.getDownloadURL();
      return fileUrl;
    } on FirebaseException {
      return "";
    }
  }
}

/*try {
      final task = MyFirebaseStorage.uploadFile(destination, file);
      if (task == null) return "";
      final snapshot = await task.whenComplete(() {});
      String attachmentUrl = await snapshot.ref.getDownloadURL();
      return attachmentUrl;
    } on FirebaseException {
      return "";
    }*/
