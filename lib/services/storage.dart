import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class Storage {
  Future uploadImageToFirebase(File _imageFile) async {
    firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('images/${_imageFile.path}');
    firebase_storage.UploadTask uploadTask = storageReference.putFile(
        _imageFile);
    await uploadTask.whenComplete(() => print('uploaded image'));
  }
  Future<File> _loadImages(String path) async {
    final firebase_storage.Reference reference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child(path);
    var text = await reference.getData();
    File image = new File.fromRawPath(text!);
    return image;
  }
}