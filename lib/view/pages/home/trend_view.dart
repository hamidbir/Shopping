import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/home_page_controller.dart';
import 'package:shopping_shoe/controller/shoe_card_controller.dart';
import 'package:shopping_shoe/utils/app_clipper.dart';

class TrendView extends StatelessWidget {
  const TrendView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomePageController homeControll = Get.find();

    return SizedBox(
      height: 350,
      child: Obx(() {
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: homeControll.trendList.length,
            itemBuilder: (context, index) {
              return buildItem(homeControll, index);
            });
      }),
    );
  }

  Widget buildItem(HomePageController homeControll, int index) {
    ShoeCardController shoeControll = Get.find();
    return InkWell(
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        shoeControll.shoe = homeControll.trendList[index];
        shoeControll.selectedSize.value =
            homeControll.trendList[index].size.first;
        shoeControll.selectedColor.value =
            homeControll.trendList[index].colors.first;
        homeControll.trendList[index].view++;
        shoeControll.updateShoe();
        Get.toNamed('/detail_shoe');
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 5),
              child: buildItemTrendList(homeControll.trendList[index]),
            ),
            Positioned(
                bottom: 80,
                right: 10,
                child: SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.network(
                        homeControll.trendList[index].imageURL[0]))),
          ],
        ),
      ),
    );
  }
}
