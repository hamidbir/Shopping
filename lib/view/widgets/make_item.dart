import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/home_page_controller.dart';
import 'package:shopping_shoe/controller/profile_controller.dart';
import 'package:shopping_shoe/controller/shoe_card_controller.dart';
import 'package:shopping_shoe/model/shoe.dart';

Widget makeItem(Shoe shoe, int index, {bool isFav = false}) {
  //For home page
  final HomePageController homeControll = Get.find();

  ShoeCardController shoeControll = Get.find();

  return InkWell(
    onTap: () {
      shoeControll.shoe = homeControll.newShoeList[index];
      shoeControll.selectedSize.value =
          homeControll.newShoeList[index].size.first;
      shoeControll.selectedColor.value =
          homeControll.newShoeList[index].colors.first;
      shoe.view++;
      shoeControll.selectedNumber.value = 1;
      shoeControll.updateShoe();
      Get.toNamed('/detail_shoe');
    },
    child: Container(
      height: 250,
      // width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          // color: ,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(shoe.imageURL[0]),
            //AssetImage('images/shoe2.jpg'),
            fit: BoxFit.cover,
          ),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 10, offset: Offset(0, 10))
          ],
          color: Color(int.parse(shoe.colors[0]))),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(shoe.name,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: (identical(int.parse(shoe.colors[0]),
                                    Colors.white.value) ||
                                identical(int.parse(shoe.colors[0]),
                                    Colors.yellow.value))
                            ? Colors.black
                            : Colors.white,
                      )),
                ),
                const SizedBox(height: 10),
                SizedBox(
                    width: double.infinity,
                    height: 30,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: shoe.category.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  //color: color == Colors.white?
                                  color: Colors.black.withOpacity(0.5),
                                  //  : color.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Center(
                                  child: Text(shoe.category[index],
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                )),
                          );
                        })),
              ],
            ),
          ),
          isFav
              ? Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      MyProfileController myProfileController = Get.find();
                      myProfileController.deleteFav(shoe);
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.red)),
                      child: const Center(
                          child: Icon(
                        Icons.delete,
                        color: Colors.red,
                        //size: 15,
                      )),
                    ),
                  ),
                )
              : Obx(() {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        shoeControll.shoe = homeControll.newShoeList[index];
                        shoeControll.cFav();
                      },
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: Colors.red)),
                        child: Center(
                            child: FlareActor(
                          'assets/Like.flr',
                          alignment: Alignment.center,
                          fit: BoxFit.contain,
                          animation: shoe.isFav.value,
                        )),
                      ),
                    ),
                  );
                }),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                //color: color == Colors.white
                /*?*/ //color: Colors.blue.withOpacity(0.5),
                // : color.withOpacity(0.3),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(shoe.price,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: (identical(int.parse(shoe.colors[0]),
                                Colors.white.value) ||
                            identical(
                                int.parse(shoe.colors[0]), Colors.yellow.value))
                        ? Colors.black
                        : Colors.white,
                  )),
            ),
          ),
        ],
      ),
    ),
  );
}
