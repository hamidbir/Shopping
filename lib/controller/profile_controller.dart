import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/auth_controller.dart';
import 'package:shopping_shoe/controller/fav_controller.dart';
import 'package:shopping_shoe/model/shoe.dart';
import 'package:shopping_shoe/repository/cloud_function.dart';
import 'package:shopping_shoe/utils/storage.dart';

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
      print('error is ' + e.toString());
      isNetworkError.value = true;
    } catch (e) {
      isNetworkError.value = true;
    }
    isLoading.value = false;
  }

  // Future fetchFavData() async {
  //   isLoading.value = true;
  //   try {
  //     final List<QueryDocumentSnapshot> favResult =
  //         await CloudFunction().getFromFavorites(auth.userId);

  //     favList.clear();
  //     for (int i = 0; i < favResult.length; i++) {
  //       //print(favResult[i].data());
  //       Shoe shoe = Shoe.fromMap(favResult[i]);

  //       favList.add(shoe);
  //     }
  //     // print('fav1 ${favList[0].runtimeType}');
  //     print('fav1 ${favList.length}');
  //   } on Exception {
  //     isNetworkError.value = true;
  //   } catch (e) {
  //     print(e.toString());
  //     isNetworkError.value = true;
  //   }
  // }

  Future deleteFav(Shoe shoe) async {
    isLoading.value = true;
    await CloudFunction().delAsFavorites(shoe, auth.userId);
    fav.fetchFavData();
    favList.value = fav.favList;
    isLoading.value = false;
  }
}
