import 'package:get/get.dart';
import 'package:shopping_shoe/controller/auth_controller.dart';
import 'package:shopping_shoe/model/shoe.dart';
import 'package:shopping_shoe/repository/cloud_function.dart';
import 'package:shopping_shoe/utils/map_function.dart';

class ShoeCardController extends GetxController {
  late Shoe shoe;
  final AuthController auth = Get.find();
  //final BagController bagController = Get.put(BagController());
  //final AuthController authController = Get.find();
  //final FavController favouritesController = Get.put(FavController());
  var isLoading = false.obs;
  var selectedSize = ''.obs;
  var selectedColor = ''.obs;
  var addedToCart = false.obs;
  var favourite = false.obs;
  //var favManage = 'Idle'.obs;

  // void changeFavourite() async {
  //   await CloudFunction().addToafavorites(shoe.toMap());
  //   await favouritesController.fetchFavData();
  //   favourite.value = !favourite.value;
  // }

  void selectSize(int index) async {
    isLoading.value = true;
    selectedSize.value = shoe.size[index];

    isLoading.value = false;
  }

  void cFav() async {
    if (shoe.isFav.value == 'Idle' ||
        shoe.isFav.value ==
            'Unlike' /*favManage.value == 'Idle' || favManage.value == 'Unlike'*/) {
      await CloudFunction().addToafavorites(shoe.toMap(), auth.userId);
      shoe.isFav.value = 'Like';
      //favShoe.add(shoe);
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

  Future/*<bool>*/ addToCart() async {
    isLoading.value = true;
    Map<String, dynamic> productMap = {
      'id': shoe.id,
      'name': shoe.name,
      // 'brand': shoe.brand,
      // 'category': shoe.category,
      'imageURL': listToMap(shoe.imageURL),
      'price': shoe.price,
      'color': listToMap([selectedColor.value]),
      'size': listToMap([selectedSize.value]),
      // 'description': shoe.description,
      // 'rating': shoe.rating,
    };

    // await CloudFunction()
    //     .addToCart(authController.userId /*Storage().getUid()*/, productMap);
    //await bagController.fetchBagItem();
    // await favouritesController.fetchFavData();
    addedToCart.value = true;
    isLoading.value = false;
  }
}
