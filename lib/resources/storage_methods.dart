import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Adding image to firebase storage
  Future<String> uploadImageToStorage(
      String name, Uint8List file, bool isPost) async {
    Reference ref = _storage.ref().child(name).child(_auth.currentUser!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  //Delete an image from storage
  Future<void> deleteFile(String fileUrl) async {
  try {
    // Reference to the file to be deleted
    Reference storageRef = FirebaseStorage.instance.refFromURL(fileUrl);

    // Delete the file
    await storageRef.delete();

    print('File deleted successfully');
  } catch (err) {
    print('Error deleting file: $err');
  }
}
}
