import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Uint8List> compressImage(Uint8List list, width, height) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: height,
      minWidth: width,
    );
    return result;
  }

  //Adding image to firebase storage
  Future<String> uploadImageToStorage(
      String name, Uint8List file, bool isPost) async {
    Reference ref = _storage.ref().child(name).child(_auth.currentUser!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
      var compressedFile = await compressImage(file, 800, 1000);
      file = compressedFile;
    }
    if (isPost == false) {
      var compressedFile = await compressImage(file, 400, 400);
      file = compressedFile;
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
