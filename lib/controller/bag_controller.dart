import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/auth_controller.dart';
import 'package:shopping_shoe/model/bag_model.dart';
import 'package:shopping_shoe/repository/cloud_function.dart';

class BagController extends GetxController {
  var isLoading = true.obs;
  var isNetworkError = false.obs;
  var itemList = <BagModel>[].obs;

  var totalPriceOld = 0.obs;
  var totalPrice = 0.obs;
  AuthController auth = Get.find();

  @override
  void onInit() {
    super.onInit();
    fetchBagItem();
  }

  Future<void> deleteShoeAsCart(int index) async {
    isLoading.value = true;
    await CloudFunction().delAsCart(itemList[index], auth.userId);
    totalPriceOld.value = totalPrice.value;
    fetchBagItem();
    isLoading.value = false;
  }

  Future fetchBagItem() async {
    totalPrice.value = 0;
    isLoading.value = true;
    isNetworkError.value = true;
    try {
      final List<QueryDocumentSnapshot> result =
          await CloudFunction().getFromCart(auth.userId /*Storage().getUid()*/);
      itemList.clear();
      for (var shoe in result) {
        itemList.add(BagModel.fromMap(shoe.data()));
        totalPrice.value = totalPrice.value + int.parse(shoe.get('price'));
      }
    } on Exception {
      debugPrint('error occure');
      isNetworkError.value = true;
    } catch (e) {
      isNetworkError.value = true;
    }
    isLoading.value = false;
  }
}
