import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/home_page_controller.dart';
import 'package:shopping_shoe/controller/shoe_card_controller.dart';
import 'package:shopping_shoe/view/pages/home_page.dart';
import 'package:shopping_shoe/view/pages/trend_view.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShoeCardController shoeControll = Get.put(ShoeCardController());
    final HomePageController homeControll = Get.put(HomePageController());

    return Scaffold(
      body: Column(
        children: [
          const Expanded(flex: 4, child: TrendView()),
          Expanded(
              flex: 6,
              child: Container(color: Colors.yellow, child: const HomePage())),
        ],
      ),
    );
  }
}
