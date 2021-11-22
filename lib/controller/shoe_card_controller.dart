import 'package:get/get.dart';
import 'package:shopping_shoe/controller/auth_controller.dart';
import 'package:shopping_shoe/model/bag_model.dart';
import 'package:shopping_shoe/model/shoe.dart';
import 'package:shopping_shoe/repository/cloud_function.dart';

class ShoeCardController extends GetxController {
  late Shoe shoe;
  final AuthController auth = Get.find();
  var isLoading = false.obs;
  var selectedSize = ''.obs;
  var selectedColor = ''.obs;
  var addedToCart = false.obs;
  var favourite = false.obs;

  void selectSize(int index) async {
    isLoading.value = true;
    selectedSize.value = shoe.size[index];

    isLoading.value = false;
  }

  void cFav() async {
    if (shoe.isFav.value == 'Idle' || shoe.isFav.value == 'Unlike') {
      await CloudFunction().addToafavorites(shoe.toMap(), auth.userId);
      shoe.isFav.value = 'Like';
    } else {
      await CloudFunction().delAsFavorites(shoe, auth.userId);
      shoe.isFav.value = 'Unlike';
    }
  }

  void selectColor(int index) async {
    isLoading.value = true;
    selectedColor.value = shoe.colors[index];

    isLoading.value = false;
  }

  Future<bool> addToCart() async {
    isLoading.value = true;
    BagModel bag = BagModel(
        shoeId: shoe.id,
        shoeName: shoe.name,
        shoeColor: selectedColor.value,
        shoeSize: selectedSize.value,
        shoeImg: shoe.imageURL[0],
        shoePrice: shoe.price);
    await CloudFunction().addToCart(auth.userId, bag.toMap());
    isLoading.value = false;
    return true;
  }

  void updateShoe() async {
    await CloudFunction().updateViewShoe(shoe.toMap(), shoe.id);
  }
}
