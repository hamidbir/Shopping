import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/bag_controller.dart';
import 'package:shopping_shoe/utils/app_clipper.dart';
import 'package:shopping_shoe/utils/countup.dart';
import 'package:shopping_shoe/view/widgets/loading_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BagController bagControll = Get.put(BagController());
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
          body: Row(
        children: [
          Expanded(
              child: Container(
            color: Colors.yellow,
            child: Obx(() {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('مجموع:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                  Countup(
                    begin: bagControll.totalPriceOld.value.toDouble(),
                    end: bagControll.totalPrice.value.toDouble(),
                    duration: const Duration(seconds: 3),
                    separator: ',',
                    style: const TextStyle(
                      fontSize: 36,
                    ),
                  ),
                  // Text(bagControll.totalPrice.value.toString(),
                  //     style: const TextStyle(
                  //         fontWeight: FontWeight.bold, fontSize: 28)),
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
            }),
          )),
          Expanded(
              child: SizedBox(
                  height: double.infinity,
                  child: Obx(() {
                    if (bagControll.isLoading.value) {
                      return loadingWidget();
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
                          itemCount: bagControll.itemList.length,
                          itemBuilder: (context, index) {
                            return buildItemCartList(index);
                          },
                        ),
                      );
                    }
                  }))),
        ],
      )),
    );
  }
}
