import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/shoe_card_controller.dart';
import 'package:shopping_shoe/utils/color_const.dart';

Widget buildImage(
  BuildContext context,
) {
  final ShoeCardController shoeControll = Get.find();
  return Expanded(
    flex: 1,
    child: Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(int.parse(shoeControll.shoe.colors[0])),
        image: DecorationImage(
          image: NetworkImage(shoeControll.shoe.imageURL[0]),
          fit: BoxFit.cover,
        ),
        boxShadow: const [
          BoxShadow(
              color: ColorConstants.grey, blurRadius: 10, offset: Offset(0, 10))
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 25, bottom: 25),
                child: InkWell(
                  onTap: () {
                    shoeControll.cFav();
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConstants.white,
                      border: Border.all(color: Colors.red),
                    ),
                    child: Center(
                        child: FlareActor(
                      'assets/Like.flr',
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                      animation: shoeControll.shoe.isFav.value,
                    )),
                  ),
                ),
              ),
            ]),
      ),
    ),
  );
}
