import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/auth_controller.dart';
import 'package:shopping_shoe/model/shoe.dart';
import 'package:shopping_shoe/repository/cloud_function.dart';

class FavController extends GetxController {
  final AuthController auth = Get.find();
  var isLoading = true.obs;
  var isNetError = false.obs;
  var favList = [].obs;
  @override
  void onInit() {
    super.onInit();
    fetchFavData();
  }

  Future fetchFavData() async {
    isLoading.value = true;
    try {
      final List<QueryDocumentSnapshot> favResult =
          await CloudFunction().getFromFavorites(auth.userId);

      favList.clear();
      for (int i = 0; i < favResult.length; i++) {
        //print(favResult[i].data());
        Shoe shoe = Shoe.fromMap(favResult[i]);

        favList.add(shoe);
      }
    } on Exception {
      isNetError.value = true;
    } catch (e) {
      debugPrint(e.toString());
      isNetError.value = true;
    }
  }
}
