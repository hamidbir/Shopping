import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/shoe_card_controller.dart';

Widget buildItemSize(int index) {
  ShoeCardController shoeControll = Get.find();
  return InkWell(
    hoverColor: Colors.transparent,
    focusColor: Colors.transparent,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: () {
      shoeControll.selectSize(index);
    },
    child: Container(
      width: 40,
      height: 30,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color:
              shoeControll.selectedSize.value == shoeControll.shoe.size[index]
                  ? Colors.black.withOpacity(0.5)
                  : Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(shoeControll.shoe.size[index],
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: shoeControll.selectedSize.value ==
                        shoeControll.shoe.size[index]
                    ? Colors.white
                    : Colors.black)),
      ),
    ),
  );
}
