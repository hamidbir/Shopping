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
  int oldNumber = 0;
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
        itemList.last.shoePrice =
            (int.parse(itemList.last.shoePrice) * itemList.last.selectNumber)
                .toString();
        totalPrice.value =
            totalPrice.value + int.parse(itemList.last.shoePrice);
      }
    } on Exception {
      debugPrint('error occure');
      isNetworkError.value = true;
    } catch (e) {
      isNetworkError.value = true;
    }
    isLoading.value = false;
  }

  Future updateNumberShoe(int index, {bool inc = false}) async {
    if (inc) {
      itemList[index].selectNumber = itemList[index].selectNumber + 1;
      print(itemList[index].selectNumber);
    } else {
      if (itemList[index].selectNumber > 1) {
        itemList[index].selectNumber = itemList[index].selectNumber - 1;
      }
      print(itemList[index].selectNumber);
    }

    await CloudFunction().updateNumberBag(itemList[index], auth.userId);
    await fetchBagItem();
  }

  Future<int> payment() async {
    isLoading.value = true;
    int comp = -1;
    for (var item in itemList) {
      comp = await CloudFunction().paymentNumberBag(item);
      print('Copm : $comp');
      if (comp == -3) {
        await CloudFunction().delAsCart(item, auth.userId);
      } else if (comp == -2) {
        await CloudFunction().updateNumberBag(item, auth.userId);
        comp = -2;
      } else {
        await CloudFunction()
            .updateNumberBag(item, auth.userId, updateNumber: comp);
        comp = -4;
      }
    }
    await fetchBagItem();
    isLoading.value = false;
    return comp;
  }
}
