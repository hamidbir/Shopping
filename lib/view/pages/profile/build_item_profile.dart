import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/profile_controller.dart';
import 'package:shopping_shoe/utils/constants.dart';
import 'package:shopping_shoe/view/pages/profile/show_fav.dart';

Widget buildItemProfile(int index, BuildContext context) {
  final MyProfileController myProfileController = Get.find();
  return InkWell(
    onTap: () {
      if (index == 0) {
        myProfileController.refresh();
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        if (myProfileController.favList.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('به کفشی علاقه ای نشون ندادی')));
        } else {
          showDialog(
              context: context, builder: (context) => showFav(width, height));
        }
      }
    },
    child: Card(
        color: const Color.fromRGBO(251, 243, 228, 0.9),
        child: Stack(
          children: [
            Center(
              child: Constants.icons[index],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(Constants.items[index],
                  style: const TextStyle(fontSize: 22, color: Colors.black)),
            ),
          ],
        )),
  );
}
