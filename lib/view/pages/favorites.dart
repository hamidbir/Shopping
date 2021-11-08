import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/fav_controller.dart';
import 'package:shopping_shoe/controller/shoe_card_controller.dart';
import 'package:shopping_shoe/utils/color_const.dart';
import 'package:shopping_shoe/view/pages/detail_shoe.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FavController favControll = Get.put(FavController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
          centerTitle: true,
        ),
        body: Obx(() {
          if (favControll.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: ColorConstants.white,
              ),
            );
          } else if (favControll.isNetError.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text('مشکلی پیش آمد!'),
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextButton(
                    onPressed: () {
                      favControll.fetchFavData();
                    },
                    child: const Text('تلاش دوباره'),
                  ),
                ],
              ),
            );
          } else if (favControll.favList.isEmpty) {
            return const Center(
              child: Text('هیچ موردی یافت نشد'),
            );
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: favControll.favList.length,
              itemBuilder: (context, index) {
                ShoeCardController shoeControll = Get.find();
                shoeControll.shoe = favControll.favList[index];
                return const DetailShoe();
              },
            );
          }
        }));
  }
}
