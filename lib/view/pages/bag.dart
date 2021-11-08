import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/bag_controller.dart';
import 'package:shopping_shoe/model/bag_model.dart';
import 'package:shopping_shoe/utils/color_const.dart';
import 'package:shopping_shoe/widgets/bag_card.dart';

class Bag extends StatelessWidget {
  const Bag({Key? key}) : super(key: key);
  // static const Map<String, dynamic> map = {'test': 'success'};
  @override
  Widget build(BuildContext context) {
    final BagController bagController = Get.put(BagController());
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 80.0,
                ),
                const Text(
                  'سبد خرید',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 35.0,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Obx(() {
                  if (bagController.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: ColorConstants.white,
                      ),
                    );
                  } else if (bagController.isNetworkError.value) {
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
                            onPressed: () {
                              bagController.fetchBagItem();
                            },
                            child: const Text('تلاش دوباره'),
                          ),
                        ],
                      ),
                    );
                  } else if (bagController.itemList.isEmpty) {
                    return const Center(
                      child: Text('هیچ موردی پیدا نشد'),
                    );
                  } else {
                    return Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(() {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: bagController.itemList.length,
                            itemBuilder: (context, index) {
                              final bagItem = bagController.itemList[index];
                              return BagCard(
                                  product: BagModel(
                                      productName: bagItem.name,
                                      prductColor: bagItem.colors[0],
                                      productSize: bagItem.size[0],
                                      prodctQuantity: 1,
                                      productPrice: bagItem.price,
                                      productImg: bagItem.imageURL[0]));
                            },
                          );
                        }),
                        Center(
                          child: Container(
                            margin:
                                const EdgeInsets.only(top: 25.0, bottom: 10.0),
                            child: Text(
                              'قیمت پایانی: \$${bagController.totalPrice}',
                              style: const TextStyle(fontSize: 25.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('پرداخت'),
                          ),
                        ),
                      ],
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
