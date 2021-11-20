import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/bottom_nav_bar_controller.dart';
import 'package:shopping_shoe/utils/color_const.dart';
import 'package:shopping_shoe/view/pages/bag.dart';
import 'package:shopping_shoe/view/pages/category.dart';
import 'package:shopping_shoe/view/pages/favorites.dart';
import 'package:shopping_shoe/view/pages/home/home_page.dart';
import 'package:shopping_shoe/view/pages/my_profile.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const listRoute = [HomePage(), Category(), Bag(), Favorites(), MyProfile()];
    final BottomNavBarController bottomNavigationController =
        Get.put(BottomNavBarController());
    return Scaffold(
        body: Obx(() {
          return listRoute[bottomNavigationController.currentIndex];
        }),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: bottomNavigationController.currentIndex,
              backgroundColor: ColorConstants.background,
              onTap: (index) => bottomNavigationController.changeIndex(index),
              selectedItemColor: ColorConstants.primary,
              unselectedItemColor: ColorConstants.grey,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'خانه'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart), label: 'دسته بندی'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_bag), label: 'سبد خرید'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'موردعلاقه ها'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.supervised_user_circle_outlined),
                    label: 'Profile'),
              ]),
        ));
  }
}
