import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/profile_controller.dart';
import 'package:shopping_shoe/utils/constants.dart';
import 'package:shopping_shoe/view/pages/profile/build_item_profile.dart';
import 'package:shopping_shoe/view/widgets/loading_widget.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyProfileController myProfileController =
        Get.put(MyProfileController());
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return Future.value(true);
      },
      child: Scaffold(
        body: Obx(() {
          if (myProfileController.isLoading.value) {
            return loadingWidget();
          } else if (myProfileController.isNetworkError.value) {
            return Center(
              child: Column(
                children: [
                  const Text('مشکلی پیش آمد'),
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextButton(
                    onPressed: () {
                      myProfileController.getUserDetail();
                    },
                    child: const Text('تلاش دوباره'),
                  ),
                ],
              ),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  myProfileController.userName.value,
                  style: const TextStyle(fontSize: 25.0, color: Colors.black),
                ),
                Text(
                  myProfileController.email.value,
                  style: const TextStyle(fontSize: 25.0, color: Colors.black),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: GridView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 8,
                      ),
                      itemCount: Constants.items.length,
                      itemBuilder: (context, index) {
                        return buildItemProfile(index, context);
                      }),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
