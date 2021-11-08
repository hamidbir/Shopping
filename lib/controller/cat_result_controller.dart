import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/model/shoe.dart';
import 'package:shopping_shoe/repository/cloud_function.dart';

class CatResultController extends GetxController {
  var isLoading = true.obs;
  var selectedCat = ''.obs;
  var resultList = <Shoe>[].obs;
  var isNetworkError = false.obs;

  loadData(String value) async {
    isLoading.value = true;
    isNetworkError.value = false;
    selectedCat.value = value;
    try {
      final List<QueryDocumentSnapshot> result =
          await CloudFunction().getCategory(value);
      resultList.clear();
      for (var shoe in result) {
        print(shoe.data());
        resultList.add(Shoe.fromMap(shoe.data() as Map<String, dynamic>));
      }
      print('size of resultList = ${resultList.length}');
    } on IOException {
      print('error occure ');
      isNetworkError.value = true;
    } catch (e) {
      print('error occure $e');
      isNetworkError.value = true;
    }
    isLoading.value = false;
  }
}
