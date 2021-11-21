import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/home_page_controller.dart';
import 'package:shopping_shoe/view/widgets/loading_widget.dart';
import 'package:shopping_shoe/view/widgets/make_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final HomePageController homeControll = Get.find();

    return SafeArea(child: Scaffold(
      body: Obx(() {
        if (homeControll.isNetError.value) {
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
                    homeControll.fetchHomePageData(forceLoad: true);
                  },
                  child: const Text('دوباره'),
                ),
              ],
            ),
          );
        } else {
          return homeControll.isLoading.value
              ? loadingWidget()
              : SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 8,
                          ),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: homeControll.newShoeList.length,
                          itemBuilder: (context, index) {
                            return makeItem(
                                homeControll.newShoeList[index], index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
        }
      }),
    ));
  }
}
