import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/auth_controller.dart';
import 'package:shopping_shoe/controller/fav_controller.dart';
import 'package:shopping_shoe/model/shoe.dart';
import 'package:shopping_shoe/repository/cloud_function.dart';

class MyProfileController extends GetxController {
  AuthController auth = Get.find();
  FavController fav = Get.find();
  var isLoading = true.obs;
  var userName = ''.obs;
  var email = ''.obs;
  var isNetworkError = false.obs;
  var favList = [].obs;
  @override
  void onInit() {
    super.onInit();
    getUserDetail();
    fav.fetchFavData();
    favList.value = fav.favList;
  }

  @override
  void onReady() {
    super.onReady();
    fav.fetchFavData();
    favList.value = fav.favList;
  }

  @override
  void refresh() {
    fav.fetchFavData();
  }

  getUserDetail() async {
    isLoading.value = true;
    isNetworkError.value = false;
    //   print(Storage().getUid());
    try {
      final userdetails = await CloudFunction().getUserDetail(auth.userId);

      userName.value = userdetails['username'];
      email.value = userdetails['email'];
    } on Exception catch (e) {
      debugPrint('error is ' + e.toString());
      isNetworkError.value = true;
    } catch (e) {
      isNetworkError.value = true;
    }
    isLoading.value = false;
  }

  Future deleteFav(Shoe shoe) async {
    isLoading.value = true;
    await CloudFunction().delAsFavorites(shoe, auth.userId);
    fav.fetchFavData();
    favList.value = fav.favList;
    isLoading.value = false;
  }
}
