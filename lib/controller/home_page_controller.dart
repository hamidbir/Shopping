import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/fav_controller.dart';
import 'package:shopping_shoe/model/shoe.dart';
import 'package:shopping_shoe/repository/cloud_function.dart';

class HomePageController extends GetxController {
  FavController fav = Get.put(FavController());
  var isLoading = false.obs;
  var isNetError = false.obs;
  var newShoeList = <Shoe>[].obs;
  var trendList = <Shoe>[].obs;
  var bannerList = <String>[].obs;
  @override
  void onReady() {
    super.onReady();
    fav.fetchFavData();
    fetchHomePageData();
  }

  @override
  void onInit() {
    super.onInit();
    fav.fetchFavData();
    fetchHomePageData();
  }

  Future fetchHomePageData({bool forceLoad = false}) async {
    if (forceLoad) {
      newShoeList.clear();
      trendList.clear();
    }
    if (newShoeList.isEmpty) {
      isLoading.value = true;
      isNetError.value = false;
      bannerList.clear();
      try {
        final List<QueryDocumentSnapshot> resultNew =
            await CloudFunction().getnewProducts();

        // final List<QueryDocumentSnapshot> resultTrend =
        //     await CloudFunction().getTrend();
        newShoeList.clear();
        trendList.clear();

        for (int i = 0; i < resultNew.length; i++) {
          Shoe shoe = Shoe.fromMap(resultNew[i]);
          //-- chck view greather than 50 add to trend list

          if (shoe.view >= 50) {
            trendList.add(shoe);
          }
          if (fav.favList.isNotEmpty) {
            for (Shoe item in fav.favList) {
              if (shoe.id == item.id) {
                shoe.isFav.value = 'Like';
                break;
              }
            }
          }
          newShoeList.add(shoe);
        }

        // for (var item in resultTrend) {
        //   trendList.add(Shoe.fromMap(item.data() as Map<String, dynamic>));
        // }
      } on IOException {
        isNetError.value = true;
      } catch (e) {
        print(e.toString());
        isNetError.value = true;
      }
      isLoading.value = false;
    }
  }
}
