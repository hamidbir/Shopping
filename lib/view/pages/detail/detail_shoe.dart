import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/shoe_card_controller.dart';

import 'package:shopping_shoe/view/pages/detail/build_image.dart';
import 'package:shopping_shoe/view/pages/detail/build_item_color.dart';
import 'package:shopping_shoe/view/pages/detail/build_item_size.dart';
import 'package:shopping_shoe/view/pages/detail/show_price.dart';
import 'package:shopping_shoe/view/widgets/counter_shoe.dart';
import 'package:shopping_shoe/view/widgets/loading_widget.dart';

class DetailShoe extends StatelessWidget {
  const DetailShoe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShoeCardController shoeControll = Get.find();

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildImage(context),
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
                            decoration: BoxDecoration(
                              // Check if  first color is white then color background is light blue

                              color: identical(
                                      int.parse(shoeControll.shoe.colors[0]),
                                      Colors.white.value)
                                  ? Colors.lightBlue.shade50
                                  : Color(int.parse(
                                          shoeControll.shoe.colors[0]))
                                      .withOpacity(0.5),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(shoeControll.shoe.name,
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        //Check if backgroud lightBlue or yellow text color chaged to black
                                        color: (identical(
                                                    int.parse(shoeControll
                                                        .shoe.colors[0]),
                                                    Colors.white.value) ||
                                                identical(
                                                    int.parse(shoeControll
                                                        .shoe.colors[0]),
                                                    Colors.yellow.value))
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
                                        //Check if backgroud lightBlue or yellow text color chaged to black
                                        color: (identical(
                                                    int.parse(shoeControll
                                                        .shoe.colors[0]),
                                                    Colors.white.value) ||
                                                identical(
                                                    int.parse(shoeControll
                                                        .shoe.colors[0]),
                                                    Colors.yellow.value))
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
                                      return buildItemSize(index);
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
                                    itemCount: shoeControll.shoe.colors.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: buildItemColor(index),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('تعداد جفت',
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
                                            ? Colors.black
                                            : Colors.white,
                                      )),
                                ),
                                Container(
                                  color: Colors.yellow,
                                  child: Obx(() {
                                    return CounterShoe(
                                        count:
                                            shoeControll.selectedNumber.value,
                                        upperClick: () {
                                          if (shoeControll
                                                  .selectedNumber.value <=
                                              shoeControll.shoe.number) {
                                            shoeControll.selectedNumber.value =
                                                shoeControll
                                                        .selectedNumber.value +
                                                    1;
                                          } else {
                                            Get.snackbar('هشدار',
                                                'شما حداکثر تعداد کفش ها را انتخاب کرده اید',
                                                backgroundColor:
                                                    Colors.orangeAccent);
                                          }
                                        },
                                        downerClick: () {
                                          if (shoeControll
                                                  .selectedNumber.value >
                                              1) {
                                            shoeControll.selectedNumber.value =
                                                shoeControll
                                                        .selectedNumber.value -
                                                    1;
                                          }
                                        });
                                  }),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    showPrice(),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: shoeControll.isLoading.value
                                            ? loadingWidget()
                                            : InkWell(
                                                onTap: () async {
                                                  await shoeControll.addToCart()
                                                      ? Get.snackbar(
                                                          'افزوده شد',
                                                          'با موفیقت افزوده شد',
                                                          backgroundColor:
                                                              Colors
                                                                  .greenAccent)
                                                      : Get.snackbar('خطا',
                                                          'دوباره امتحان کنید',
                                                          backgroundColor:
                                                              Colors.redAccent);
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
              //}
              ),
        ),
      ),
    );
  }
}
