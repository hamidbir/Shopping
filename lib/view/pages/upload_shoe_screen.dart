import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

List<Uint8List> uploadedImage = [];
List<String> imageUpload = [];
String image = '';
int counter = 0;
bool c = false;

class UploadImageScreen extends StatefulWidget {
  //final String user;
  const UploadImageScreen({
    Key? key,
    /*required this.user*/
  }) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          actions: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    uploadToStorage('eMlgqmMoq9Zi2mMc9Q4jWrsBSl72');
                    counter++;
                  });
                },
                child: Text(counter.toString()))
          ],
        ),
        body: SizedBox(
            width: size.width,
            height: size.height,
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return SizedBox(
                      width: 150,
                      height: 150,
                      child: Image.memory(uploadedImage[index]));
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: uploadedImage.length))
        // : Center(
        //     child: SizedBox(
        //         width: 150, height: 150, child: Image.network(image)))
        );
  }
}

void uploadImage({required Function(File file) onSelected}) {
  InputElement uploadElement = (FileUploadInputElement() as InputElement)
    ..accept = 'image/*';
  uploadElement.click();
  uploadElement.onChange.listen((event) {
    final file = uploadElement.files!.first;
    final reader = FileReader();
    reader.readAsDataUrl(file);
    reader.onLoadEnd.listen((event) {
      var res = reader.result.toString();
      String ress = res.substring(res.indexOf(',') + 1);

      Uint8List image = base64.decode(ress);
      uploadedImage.add(image);
      onSelected(file);

      print('done');
    });
  });
}

void uploadToStorage(String userId) {
  final dateTime = DateTime.now();
  //final userId = user.uid;
  final path = '$userId/$dateTime';
  uploadImage(onSelected: (file) async {
    final ref = FirebaseStorage.instance
        .refFromURL('gs://shoppin-shoe.appspot.com/')
        .child(path);
    await ref.putBlob(file);
    image = await ref.getDownloadURL();
    imageUpload.add(image);
  });
}
