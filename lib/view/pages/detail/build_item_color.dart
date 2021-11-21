import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/shoe_card_controller.dart';

Widget buildItemColor(int index) {
  final ShoeCardController shoeControll = Get.find();
  return InkWell(
    hoverColor: Colors.transparent,
    focusColor: Colors.transparent,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: () {
      shoeControll.selectColor(index);
    },
    child: CircleAvatar(
      radius: 19,
      backgroundColor:
          /* For Border Color:
        1- if One color then color border is teal 
        2- If we have several colors for border selected color, Its color is the previous color
            and for index 0 border color is last color
        */
          Color(shoeControll.shoe.colors.length == 1
              ? Colors.teal.value
              : shoeControll.selectedColor.value ==
                      shoeControll.shoe.colors[index]
                  ? index == 0
                      ? int.parse(shoeControll.shoe.colors.last)
                      : int.parse(shoeControll.shoe.colors[index - 1])
                  : Colors.transparent.value),
      child: CircleAvatar(
        radius: 17,
        backgroundColor: Color(int.parse(shoeControll.shoe.colors[index])),
      ),
    ),
  );
}
