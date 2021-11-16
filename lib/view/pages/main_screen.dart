import 'package:flare_flutter/flare_actor.dart';
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
        leading: InkWell(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ProfileView()));
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 19,
              backgroundColor: Colors.blue,
              child: Text('P'),
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CartScreen()));
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.shopping_bag),
            ),
          )
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
