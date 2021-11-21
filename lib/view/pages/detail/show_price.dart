import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/shoe_card_controller.dart';

Widget showPrice() {
  final ShoeCardController shoeControll = Get.find();
  return Expanded(
    flex: 2,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text('${shoeControll.shoe.price} تومان',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: (identical(int.parse(shoeControll.shoe.colors[0]),
                          Colors.white.value) ||
                      identical(int.parse(shoeControll.shoe.colors[0]),
                          Colors.yellow.value))
                  ? Colors.black
                  : Colors.white,
            )),
      ),
    ),
  );
}
