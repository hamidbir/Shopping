import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/bag_controller.dart';
import 'package:shopping_shoe/controller/shoe_card_controller.dart';
import 'package:shopping_shoe/model/bag_model.dart';
import 'package:shopping_shoe/model/shoe.dart';
import 'package:shopping_shoe/utils/color_const.dart';
import 'package:shopping_shoe/view/pages/auth/login.dart';
import 'package:shopping_shoe/view/pages/trend_view.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BagController bagControll = Get.put(BagController());
    return Scaffold(
        body: Row(
      children: [
        Expanded(
            child: Container(
          color: Colors.yellow,
          child: Obx(() {
            if (bagControll.isLoading.value) {
              return showLoading(context);
              // const Center(
              //   child: CircularProgressIndicator(),
              // );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('مجموع:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                  Text(bagControll.totalPrice.value.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 28)),
                  Container(
                    width: 350,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadiusDirectional.circular(15)),
                    child: const Center(
                      child: Text('پرداخت',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ],
              );
            }
          }),
        )),
        Expanded(
            child: SizedBox(
                height: double.infinity,
                child: Obx(() {
                  if (bagControll.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return SizedBox(
                      height: double.infinity,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 8,
                        ),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        //  physics: NeverScrollableScrollPhysics(),
                        itemCount: bagControll.itemList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 200,
                            margin: const EdgeInsets.only(right: 16),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: ClipPath(
                                      clipper: AppClipper(10, 100),
                                      child: Container(
                                        color: Colors.lightBlue.shade50,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                                bagControll
                                                    .itemList[index].shoeName,
                                                style: const TextStyle(
                                                    fontSize: 18)),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                            Text(
                                                bagControll
                                                    .itemList[index].shoePrice,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18)),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 19,
                                                    backgroundColor: Color(
                                                        int.parse(bagControll
                                                            .itemList[index]
                                                            .shoeColor)),
                                                  ),
                                                  const Spacer(),
                                                  Text(bagControll
                                                      .itemList[index]
                                                      .shoeSize),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                                Positioned(
                                  bottom: 110,
                                  left: 10,
                                  child: SizedBox(
                                    width: 150,
                                    height: 150,
                                    child: Image.network(
                                        bagControll.itemList[index].shoeImg),
                                  ),
                                ),
                                Positioned(
                                  left: 0.0,
                                  top: 10.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 10),
                                    child: InkWell(
                                      onTap: () {
                                        bagControll.deleteShoeAsCart(index);
                                      },
                                      child: Container(
                                          width: 25,
                                          height: 25,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: ColorConstants.white,
                                              border: Border.all(
                                                  color: Colors.red)),
                                          child: const Center(
                                              child: Icon(Icons.delete,
                                                  size: 15,
                                                  color: Colors.red))),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                }))),
      ],
    ));
  }

  Widget _buildBackground(BagModel shoe) {
    return ClipPath(
      clipper: AppClipper(15, 150),
      child: Container(
        // decoration: BoxDecoration(
        // border: Border.all(
        //     width: identical(int.parse(trendShoe[index].colors[0]),
        //             Colors.white.value)
        //         //trendShoe[index].colors[0] == '4294967295'
        //         ? 1
        //         : 0.5,
        //     color: Colors.black)),
        width: 250,
        color: identical(int.parse(shoe.shoeColor), Colors.white.value)
            ? Colors.lightBlue.shade50
            : Color(int.parse(shoe.shoeColor)),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Icon(Icons.shower, size: 40, color: Colors.white),
                  const Expanded(child: SizedBox()),
                  Container(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(shoe.shoeName,
                        textAlign: TextAlign.end,
                        maxLines: 2,
                        style: TextStyle(
                          color: (identical(int.parse(shoe.shoeColor),
                                      Colors.white.value) ||
                                  identical(int.parse(shoe.shoeColor),
                                      Colors.yellow.value))
                              //trendShoe[index].colors[0] == '4294967295'
                              ? Colors.black
                              : Colors.white,
                          fontSize: 22,
                        )),
                  ),
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 22.0),
                    child: Text(shoe.shoePrice,
                        style: TextStyle(
                            color: (identical(int.parse(shoe.shoeColor),
                                        Colors.white.value) ||
                                    identical(int.parse(shoe.shoeColor),
                                        Colors.yellow.value))
                                //Color(int.parse(trendShoe[index].colors[0])) == Colors.white.value
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  ),
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 30,
                          margin: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(shoe.shoeSize,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstants.white,
                                )),
                          ),
                        ),
                        const Spacer(),
                        CircleAvatar(
                          radius: 19,
                          backgroundColor: Colors.teal,
                          child: CircleAvatar(
                            radius: 17,
                            backgroundColor: Color(int.parse(shoe.shoeColor)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Positioned(
            //   bottom: 0,
            //   left: 0,
            //   child: Obx(() {
            //     return Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: InkWell(
            //         onTap: () {
            //           // shoeControll.shoe = ;
            //           // shoeControll.cFav();
            //         },
            //         child: Container(
            //           width: 35,
            //           height: 35,
            //           decoration: BoxDecoration(
            //               shape: BoxShape.circle,
            //               color: ColorConstants.white,
            //               border: Border.all(color: Colors.red)),
            //           child: Center(
            //               child: FlareActor(
            //             'assets/Like.flr',
            //             alignment: Alignment.center,
            //             fit: BoxFit.contain,
            //             animation: shoe.isFav.value,
            //           )),
            //         ),
            //       ),
            //     );
            //   }),
            //   // child: Container(
            //   //   width: 50,
            //   //   height: 50,
            //   //   decoration: const BoxDecoration(
            //   //       color: Colors.greenAccent,
            //   //       borderRadius: BorderRadius.only(
            //   //         topRight: Radius.circular(10),
            //   //       )),
            //   //   child: const Center(
            //   //     child: Icon(Icons.add, color: Colors.white),
            //   //   ),
            //   // ),
            // ),
          ],
        ),
      ),
    );
  }
}
