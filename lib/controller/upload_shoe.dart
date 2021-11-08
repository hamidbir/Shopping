import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadController extends GetxController {
  void uploadImage({required Function(File file) onSelected}) {
    InputElement uploadElement = (FileUploadInputElement() as InputElement)
      ..accept = 'image/*';
    uploadElement.click();
    uploadElement.onChange.listen((event) {
      final file = uploadElement.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        onSelected(file);
        print('done');
      });
    });
  }

  void uploadToStorage(User user) {
    final dateTime = DateTime.now();
    final userId = user.uid;
    final path = '$userId/$dateTime';
    uploadImage(onSelected: (file) {
      FirebaseStorage.instance
          .refFromURL('gs://shoppin-shoe.appspot.com/')
          .child(path)
          .putBlob(file);
    });
  }
}
