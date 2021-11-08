import 'dart:convert';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/home_page_controller.dart';
import 'package:shopping_shoe/controller/shoe_card_controller.dart';
import 'package:shopping_shoe/model/shoe.dart';
import 'package:shopping_shoe/utils/color_const.dart';
import 'package:shopping_shoe/view/pages/detail_shoe.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String brand = 'گلشید';
  static const String category = 'ورزشی';
  static const String nameBrand = 'نایک';
  static const String price = '100.000 تومان';
  static List<String> titleCat = [
    'همه',
    'چرم',
    'اسپورت',
    'ورزشی',
    'صندل',
    'نیم بوت'
  ];

  @override
  Widget build(BuildContext context) {
    final HomePageController homeControll = Get.put(HomePageController());
    ShoeCardController shoeControll = Get.put(ShoeCardController());
    return SafeArea(child: Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      //   centerTitle: false,
      //   title: const Text(brand,
      //       style: TextStyle(
      //           color: Colors.black,
      //           fontWeight: FontWeight.bold,
      //           fontSize: 20)),
      //   actions: [
      //     IconButton(
      //         onPressed: () {},
      //         icon: const Icon(Icons.notifications_outlined,
      //             color: Colors.black)),
      //     IconButton(
      //         onPressed: () {},
      //         icon:
      //             const Icon(Icons.shopping_bag_outlined, color: Colors.black))
      //   ],
      // ),
      body: Obx(() {
        if (homeControll.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(
            backgroundColor: ColorConstants.white,
          ));
        } else if (homeControll.isNetError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text('مشکلی پیش آمد'),
                const SizedBox(
                  height: 30.0,
                ),
                TextButton(
                  //color: ColorConstants.sale,
                  onPressed: () {
                    homeControll.fetchHomePageData(forceLoad: true);
                  },
                  child: const Text('دوباره'),
                ),
              ],
            ),
          );
        } else {
          //print(homeControll.newShoeList);
          //return const Text(' Heyyyyyyyy');
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // SizedBox(
                  //   height: 40,
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: titleCat.length,
                  //     shrinkWrap: true,
                  //     itemBuilder: (context, index) {
                  //       return AspectRatio(
                  //         aspectRatio: 2 / 1,
                  //         child: InkWell(
                  //           child: Container(
                  //               margin: const EdgeInsets.only(right: 10),
                  //               decoration: BoxDecoration(
                  //                 color: ColorConstants.grey,
                  //                 borderRadius: BorderRadius.circular(20),
                  //               ),
                  //               child: Center(
                  //                 //TODO: for font size: when cick item font size 20 and default font size 17
                  //                 child: Text(titleCat[index]),
                  //               )),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 8,
                    ),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    //  physics: NeverScrollableScrollPhysics(),
                    itemCount: homeControll.newShoeList.length,
                    itemBuilder: (context, index) {
                      return makeItem(homeControll.newShoeList[index], index);
                      //return Text(homeControll.newShoeList[index].name);
                    },
                  ),

                  // makeItem(
                  //     tag: 5, image: 'images/shoe1.jpg', color: Colors.white),
                ],
              ),
            ),
          );
        }
      }),
    ));
  }

  Widget makeItem(Shoe shoe, int index) {
    final HomePageController homeControll = Get.find();
    ShoeCardController shoeControll = Get.find();

    return InkWell(
      onTap: () {
        shoeControll.shoe = homeControll.newShoeList[index];
        shoeControll.selectedSize.value =
            homeControll.newShoeList[index].size.first;
        shoeControll.selectedColor.value =
            homeControll.newShoeList[index].colors.first;
        //shoeControll.favManage.value = 'Idle';
        Get.to(const DetailShoe());
      },
      child: Hero(
        tag: shoe.id,
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
              BoxShadow(
                  color: ColorConstants.grey,
                  blurRadius: 10,
                  offset: Offset(0, 10))
            ],
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      // decoration: BoxDecoration(
                      //   //color: color == Colors.white?
                      //   //color: Colors.blue.withOpacity(0.5),
                      //   //  : color.withOpacity(0.3),
                      //   borderRadius: BorderRadius.circular(25),
                      // ),
                      child: Text(shoe.name,
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.white)),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
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
                                              color: ColorConstants.white)),
                                    )),
                              );
                            })),
                  ],
                ),
              ),
              Obx(() {
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
                          color: ColorConstants.white,
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
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
