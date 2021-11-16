import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/home_page_controller.dart';
import 'package:shopping_shoe/controller/profile_controller.dart';
import 'package:shopping_shoe/controller/shoe_card_controller.dart';
import 'package:shopping_shoe/model/shoe.dart';
import 'package:shopping_shoe/utils/color_const.dart';
import 'package:shopping_shoe/view/pages/detail_shoe.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyProfileController myProfileController =
        Get.put(MyProfileController());
    print('user: ${myProfileController.userName.value}');
    return Scaffold(
        body: Row(
      children: [
        Expanded(child: Container(color: Colors.red)),
        Expanded(
            child: Container(
                color: Colors.black,
                child: Obx(() {
                  if (myProfileController.isLoading.value) {
                    return const Center(
                        child: CircularProgressIndicator(
                      backgroundColor: ColorConstants.white,
                    ));
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
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        myProfileController.userName.value,
                        style: const TextStyle(
                            fontSize: 25.0, color: Colors.white),
                      ),
                      Text(
                        myProfileController.email.value,
                        style: const TextStyle(
                            fontSize: 25.0, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Divider(height: 1, color: Colors.white),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          myProfileController.refresh();
                          var height = MediaQuery.of(context).size.height;
                          var width = MediaQuery.of(context).size.width;
                          print(myProfileController.favList.length);
                          if (myProfileController.favList.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('به کفشی علاقه ای نشون ندادی')));
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => showFav(width, height));
                          }
                        },
                        child: ListTile(
                          title: SettingsList.list[0],
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 20.0,
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  );
                }))),
        Expanded(child: Container(color: Colors.red)),
      ],
    ));
  }

  Widget showFav(double width, double height) {
    MyProfileController myProfileController = Get.find();

    return AlertDialog(
      title: const Text('موردعلاقه ها',
          style: TextStyle(
            color: Colors.red,
          )),
      //content: Container(width: width, height: height, color: Colors.black),
      content: Obx(() {
        if (myProfileController.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(
            backgroundColor: ColorConstants.white,
          ));
        } else {
          return SizedBox(
            width: width,
            height: height,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 8,
              ),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              //  physics: NeverScrollableScrollPhysics(),
              itemCount: myProfileController.favList.length,
              itemBuilder: (context, index) {
                return makeItem(
                    myProfileController.favList[index], index, context);
                //return const Text('sffffffffffffffffffff');
              },
            ),
          );
        }
      }),
    );
  }

  Widget makeItem(Shoe shoe, int index, BuildContext context) {
    //TODO:
    //ShoeCardController shoeControll = Get.put(ShoeCardController());
    MyProfileController myProfileController = Get.find();
    ShoeCardController shoeControll = Get.find();

    return InkWell(
      onTap: () {
        shoeControll.shoe = shoe;
        shoeControll.selectedSize.value = shoe.size.first;
        shoeControll.selectedColor.value = shoe.colors.first;
        shoe.view++;
        shoeControll.updateShoe();
        //shoeControll.favManage.value = 'Idle';
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const DetailShoe()));

//        Get.to(const DetailShoe());
      },
      child: Hero(
        tag: shoe.id,
        child: Container(
          height: 250,
          // width: double.infinity,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              // color: ,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(shoe.imageURL[0]),
                //AssetImage('images/shoe2.jpg'),
                fit: BoxFit.cover,
              ),
              boxShadow: const [
                BoxShadow(
                    color: ColorConstants.grey,
                    blurRadius: 10,
                    offset: Offset(0, 10))
              ],
              color: Color(int.parse(shoe.colors[0]))),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      // decoration: BoxDecoration(
                      //   //color: color == Colors.white?
                      //   //color: Colors.blue.withOpacity(0.5),
                      //   //  : color.withOpacity(0.3),
                      //   borderRadius: BorderRadius.circular(25),
                      // ),
                      child: Text(shoe.name,
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.white)),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                        width: double.infinity,
                        height: 30,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: shoe.category.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      //color: color == Colors.white?
                                      color: Colors.black.withOpacity(0.5),
                                      //  : color.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Center(
                                      child: Text(shoe.category[index],
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: ColorConstants.white)),
                                    )),
                              );
                            })),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    myProfileController.deleteFav(shoe);
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorConstants.white,
                        border: Border.all(color: Colors.red)),
                    child: const Center(
                        child: Icon(
                      Icons.delete,
                      color: Colors.red,
                      //size: 15,
                    )),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    //color: color == Colors.white
                    /*?*/ //color: Colors.blue.withOpacity(0.5),
                    // : color.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(shoe.price,
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsList {
  static const list = [
    InkWell(
        child: Text('مرودعلاقه',
            style: TextStyle(color: Colors.white, fontSize: 20))),
    Text('تاریخچه خرید', style: TextStyle(color: Colors.white, fontSize: 20)),
    // const Text('Shipping Address'),
    // const Text('Payment Methods'),
    // const Text('Promocodes'),
    // const Text('My reviews'),
    Text('تنظیمات', style: TextStyle(color: Colors.white, fontSize: 20))
  ];
}
