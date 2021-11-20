import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/home_page_controller.dart';
import 'package:shopping_shoe/controller/shoe_card_controller.dart';
import 'package:shopping_shoe/utils/route_transition.dart';
import 'package:shopping_shoe/view/pages/cart_screen.dart';
import 'package:shopping_shoe/view/pages/home/home_page.dart';
import 'package:shopping_shoe/view/pages/profile_view.dart';
import 'package:shopping_shoe/view/pages/home/trend_view.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ShoeCardController shoeControll = Get.put(ShoeCardController());
    final HomePageController homeControll = Get.put(HomePageController());
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        //In AppBar tWo Button : profile(go to ProfileView)  and BasketShoping(go to Cart Screen)
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            InkWell(
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Get.toNamed('/cart');
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 18),
                child: Icon(Icons.shopping_bag_outlined),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: InkWell(
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Get.toNamed('/my_profile');
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
          children: const [
            Expanded(flex: 4, child: TrendView()),
            Expanded(flex: 6, child: HomePage()),
          ],
        ),
      ),
    );
  }
}
