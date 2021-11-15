import 'dart:ui';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/shoe_card_controller.dart';
import 'package:shopping_shoe/utils/color_const.dart';

class DetailShoe extends StatelessWidget {
  const DetailShoe({Key? key /*, required this.shoe*/}) : super(key: key);
  //final Shoe shoe;

  // final String image;
  // final Color color;
  // final int tag;

  // static const String category = 'ورزشی';
  // static const String nameBrand = 'نایک';
  // static const String size = 'سایز';
  // static const String price = '100.000 تومان';

  @override
  Widget build(BuildContext context) {
    ShoeCardController shoeControll = Get.find();

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Obx(() {
            if (shoeControll.isLoading.value) {
              return const Center(
                  child: CircularProgressIndicator(
                backgroundColor: ColorConstants.white,
              ));
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 1,
                    child: Hero(
                      tag: shoeControll.shoe.id,
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
                                color: ColorConstants.grey,
                                blurRadius: 10,
                                offset: Offset(0, 10))
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // GestureDetector(
                                //   onTap: () {
                                //     Get.back();
                                //   },
                                //   child: Container(
                                //     width: 35,
                                //     height: 35,
                                //     decoration: BoxDecoration(
                                //       shape: BoxShape.circle,
                                //       // color: color == Colors.white
                                //       color: Colors.blue.withOpacity(0.1),
                                //       // : color.withOpacity(0.3),
                                //     ),
                                //     child: const Align(
                                //       alignment: Alignment.centerRight,
                                //       child: Icon(
                                //         Icons.arrow_back_ios,
                                //         color: Colors.white,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                InkWell(
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
                              ]),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/images/shoedet.png',
                            // fit: BoxFit.fill,
                          ),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3,
                              //height: double.infinity / 2,
                              decoration: BoxDecoration(
                                color: identical(
                                        int.parse(shoeControll.shoe.colors[0]),
                                        Colors.white.value)
                                    ? Colors.lightBlue.shade50
                                    : Color(int.parse(
                                            shoeControll.shoe.colors[0]))
                                        .withOpacity(0.5),
                              ),
                              
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(shoeControll.shoe.name,
                                        style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                          color: (identical(
                                                      int.parse(shoeControll
                                                          .shoe.colors[0]),
                                                      Colors.white.value) ||
                                                  identical(
                                                      int.parse(shoeControll
                                                          .shoe.colors[0]),
                                                      Colors.yellow.value))
                                              //trendShoe[index].colors[0] == '4294967295'
                                              ? Colors.black
                                              : Colors.white,
                                        )),
                                  ),
                                  const SizedBox(height: 25),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('سایز',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: (identical(
                                                      int.parse(shoeControll
                                                          .shoe.colors[0]),
                                                      Colors.white.value) ||
                                                  identical(
                                                      int.parse(shoeControll
                                                          .shoe.colors[0]),
                                                      Colors.yellow.value))
                                              //trendShoe[index].colors[0] == '4294967295'
                                              ? Colors.black
                                              : Colors.white,
                                        )),
                                  ),
                                  SizedBox(
                                    height: 80,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: shoeControll.shoe.size.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          hoverColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            shoeControll.selectSize(index);
                                            // shoeControll.selectedSize.value =
                                            //     shoeControll.shoe.size[index];
                                            //print(shoeControll.shoe.size[index]);
                                          },
                                          child: Container(
                                            width: 40,
                                            height: 30,
                                            margin: const EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                                color: shoeControll.selectedSize
                                                            .value ==
                                                        shoeControll
                                                            .shoe.size[index]
                                                    ? Colors.black
                                                        .withOpacity(0.5)
                                                    : Colors.white
                                                        .withOpacity(0.5),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                              child: Text(
                                                  shoeControll.shoe.size[index],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: shoeControll
                                                                  .selectedSize
                                                                  .value ==
                                                              shoeControll.shoe
                                                                  .size[index]
                                                          ? ColorConstants.white
                                                          : ColorConstants
                                                              .dark)),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('رنگ',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: (identical(
                                                      int.parse(shoeControll
                                                          .shoe.colors[0]),
                                                      Colors.white.value) ||
                                                  identical(
                                                      int.parse(shoeControll
                                                          .shoe.colors[0]),
                                                      Colors.yellow.value))
                                              //trendShoe[index].colors[0] == '4294967295'
                                              ? Colors.black
                                              : Colors.white,
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    height: 100,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount:
                                          shoeControll.shoe.colors.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            hoverColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () {
                                              shoeControll.selectColor(index);
                                            },
                                            child: CircleAvatar(
                                              radius: 19,
                                              //TODO: this way for selcted else Colors.transparent
                                              backgroundColor: Color(shoeControll
                                                          .shoe.colors.length ==
                                                      1
                                                  ? Colors.teal.value
                                                  : shoeControll.selectedColor
                                                              .value ==
                                                          shoeControll.shoe
                                                              .colors[index]
                                                      ? index == 0
                                                          ? int.parse(
                                                              shoeControll.shoe
                                                                  .colors.last)
                                                          : int.parse(
                                                              shoeControll.shoe
                                                                      .colors[
                                                                  index - 1])
                                                      : Colors.transparent.value),
                                              child: CircleAvatar(
                                                radius: 17,
                                                backgroundColor: Color(
                                                    int.parse(shoeControll
                                                        .shoe.colors[index])),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text(
                                                '${shoeControll.shoe.price} تومان',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: (identical(
                                                              int.parse(
                                                                  shoeControll
                                                                          .shoe
                                                                          .colors[
                                                                      0]),
                                                              Colors.white
                                                                  .value) ||
                                                          identical(
                                                              int.parse(
                                                                  shoeControll
                                                                          .shoe
                                                                          .colors[
                                                                      0]),
                                                              Colors.yellow
                                                                  .value))
                                                      //trendShoe[index].colors[0] == '4294967295'
                                                      ? Colors.black
                                                      : Colors.white,
                                                )),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () {
                                              shoeControll.addToCart();
                                            },
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.blueAccent,
                                                  borderRadius:
                                                      BorderRadiusDirectional
                                                          .circular(15)),
                                              child: const Center(
                                                child: Text('خرید',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}
