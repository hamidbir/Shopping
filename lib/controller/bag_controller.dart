import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/model/shoe.dart';
import 'package:shopping_shoe/repository/cloud_function.dart';
import 'package:shopping_shoe/utils/storage.dart';

class BagController extends GetxController {
  var isLoading = true.obs;
  var isNetworkError = false.obs;
  var itemList = <Shoe>[].obs;
  var totalPrice = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBagItem();
  }

  Future checkOut() async {
    totalPrice.value = 0.0;
    await CloudFunction().checkOut();
    itemList.clear();
    await fetchBagItem();
  }

  Future fetchBagItem() async {
    isLoading.value = true;
    isNetworkError.value = true;
    try {
      final List<QueryDocumentSnapshot> result =
          await CloudFunction().getFromCart(Storage().getUid());
      itemList.clear();
      for (var shoe in result) {
        itemList.add(Shoe.fromMap(shoe.data() as Map<String, dynamic>));
        totalPrice.value = totalPrice.value + shoe.get('price').toDouble();
      }
    } on Exception {
      print('error occure');
      isNetworkError.value = true;
    } catch (e) {
      print(e.toString());
      isNetworkError.value = true;
    }
    //isNetworkError.value = true;
    isLoading.value = false;
  }
}
