import 'dart:html';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/repository/cloud_function.dart';
import 'package:shopping_shoe/utils/constants.dart';
import 'package:shopping_shoe/utils/map_function.dart';
import 'package:uuid/uuid.dart';

class AdminController extends GetxController {
  var errorText = ''.obs;
  var currentCat = 'انتخاب دسته بندی'.obs;
  var currentColor = 'انتخاب رنگ'.obs;
  var isLoading = false.obs;
  String image = "";
  var sizes = [].obs;
  var colors = [].obs;
  var category = [].obs;
  var imageUrl = [].obs;
  //------------------------
  List<String> sizesSave = [];
  List<String> categorySave = [];
  List<String> imageUrlSave = [];
  List<String> colorsSave = [];

  late TextEditingController shoeNameConteroller;
  late TextEditingController shoePriceConteroller;
  late TextEditingController shoeCatConteroller;
  late TextEditingController shoeColorConteroller;
  late TextEditingController shoeSizeConteroller;

  @override
  void onInit() {
    super.onInit();
    shoeNameConteroller = TextEditingController();

    shoeNameConteroller = TextEditingController();
    shoeCatConteroller = TextEditingController(text: currentCat.value);
    shoeColorConteroller = TextEditingController(text: currentColor.value);
    shoeSizeConteroller = TextEditingController();
    shoePriceConteroller = TextEditingController();
  }

  void addSize() {
    sizes.add(shoeSizeConteroller.text);
    sizesSave.add(shoeSizeConteroller.text);
    shoeSizeConteroller.clear();
  }

  void removeSize(int index) {
    sizes.removeAt(index);
    sizesSave.removeAt(index);
  }

  void addColor(int index) {
    currentColor.value = Constants.colorShoe[index];

    colorsSave.add(currentColor.value);
    colors.add(currentColor.value);
    //colorsSave.add(shoeColorConteroller.text);
  }

  void removeColor(int index) {
    colors.removeAt(index);
    colorsSave.removeAt(index);
  }

  void addCategory(int index) {
    errorText.value = 'لطفا دسته بندی  کفش را انتخاب کنید';

    shoeCatConteroller.text = Constants.taskCategoryList[index];
    category.add(shoeCatConteroller.text);
    categorySave.add(shoeCatConteroller.text);
  }

  void removeCategory(int index) {
    category.removeAt(index);
    categorySave.removeAt(index);
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
        //isLoading.value = true;
        // var res = reader.result.toString();
        // String ress = res.substring(res.indexOf(',') + 1);
        // imageUrl.add(ress);
        onSelected(file);
        //isLoading.value = false;
        print('done');
      });
    });
  }

  Future<void> uploadToStorage(String userId) async {
    final dateTime = DateTime.now();
    //final userId = user.uid;
    String path =
        '${dateTime.year}${dateTime.month}${dateTime.day}${dateTime.hour}${dateTime.minute}${dateTime.second}';
    uploadImage(onSelected: (file) async {
      isLoading.value = true;

      final ref = FirebaseStorage.instance
          .refFromURL('gs://shoppin-shoe.appspot.com/')
          .child(path);
      await ref.putBlob(file);
      image = await ref.getDownloadURL();
      var uri = Uri.parse(image);

      imageUrl.add(image);
      imageUrlSave.add(image);
      isLoading.value = false;
    });
  }

  Future<bool> upload(String userId) async {
    isLoading.value = true;
    if (shoeNameConteroller.text.trim().isEmpty) {
      errorText.value = 'اسم کفش یادت رفت';
    } else if (shoePriceConteroller.text.trim().isEmpty) {
      errorText.value = 'کفش مفته!! قیمت نداره که';
    } else if (sizes.isEmpty) {
      errorText.value = 'کفش اندازه نداره';
    } else if (colors.isEmpty) {
      errorText.value = 'کفش بدون رنگه';
    } else if (category.isEmpty) {
      errorText.value = 'دسته بندی کفش رو انتخاب کنید';
    } else if (imageUrl.isEmpty) {
      errorText.value = 'لطفا عکس را انتخاب کنید';
    } else {
      String id = const Uuid().v4();
      Map<String, dynamic> shoeMap = {
        'id': id,
        'name': shoeNameConteroller.text,
        //  'brand': shoeBrandConteroller.text,
        'category': listToMap(categorySave),
        'imageURL': listToMap(imageUrlSave),
        'price': shoePriceConteroller.text,
        'colors': listToMap(colorsSave),
        'size': listToMap(sizesSave),
        'description': 'shoe is good',
        'view': 5,
        'number': 10
        //'rating': '10',
      };
      await CloudFunction().saveNewShoe(shoeMap, id /* Storage().getUid()*/);
      shoeNameConteroller.clear();
      shoePriceConteroller.clear();
      shoeCatConteroller.text = 'انتخاب دسته بندی';
      shoeColorConteroller.text = 'انتخاب رنگ';
      shoeSizeConteroller.clear();

      sizes.clear();
      colors.clear();
      category.clear();
      imageUrl.clear();

      sizesSave.clear();
      colorsSave.clear();
      categorySave.clear();
      imageUrlSave.clear();

      isLoading.value = false;
      return true;
    }

    isLoading.value = false;
    return false;
  }
}
