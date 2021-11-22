import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/profile_controller.dart';

import 'package:shopping_shoe/view/widgets/make_item.dart';

Widget showFav(double width, double height) {
  MyProfileController myProfileController = Get.find();

  return AlertDialog(
    title: const Text('موردعلاقه ها',
        style: TextStyle(
          color: Colors.red,
        )),
    content: Obx(() {
      if (myProfileController.isLoading.value) {
        return const Center(
            child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ));
      } else {
        return SizedBox(
          width: width,
          height: height,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 8,
            ),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            //  physics: NeverScrollableScrollPhysics(),
            itemCount: myProfileController.favList.length,
            itemBuilder: (context, index) {
              return makeItem(
                myProfileController.favList[index],
                index,
                isFav: true,
              );
            },
          ),
        );
      }
    }),
  );
}
