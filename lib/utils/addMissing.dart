import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class StoreData {
  Future<String> uploadImage(String childName, Uint8List file) async {
    try {
      String downloadUrl;
      Reference ref = FirebaseStorage.instance.ref();
      Reference upDir = ref.child("missingPeople");
      Reference fileName = upDir.child(childName);
      await fileName.putData(file);
      downloadUrl = await fileName.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return "$e";
    }
  }
}
