import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/home_page_controller.dart';
import 'package:shopping_shoe/controller/shoe_card_controller.dart';
import 'package:shopping_shoe/view/pages/cart_screen.dart';
import 'package:shopping_shoe/view/pages/home_page.dart';
import 'package:shopping_shoe/view/pages/profile_view.dart';
import 'package:shopping_shoe/view/pages/trend_view.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShoeCardController shoeControll = Get.put(ShoeCardController());
    final HomePageController homeControll = Get.put(HomePageController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CartScreen()));
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 18),
              child: Icon(Icons.shopping_bag),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfileView()));
              },
              child: const CircleAvatar(
                radius: 19,
                backgroundColor: Colors.blue,
                child: Text('P'),
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
        ],
      ),
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
