import 'package:auto_size_text/auto_size_text.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/bag_controller.dart';
import 'package:shopping_shoe/controller/shoe_card_controller.dart';
import 'package:shopping_shoe/model/shoe.dart';

//This Class create shape background  for trendview and cart
class AppClipper extends CustomClipper<Path> {
  final double cornerSize;
  final double diagonalHeight;

  AppClipper(this.cornerSize, this.diagonalHeight);
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, cornerSize * 1.5);
    path.lineTo(0, size.height - cornerSize);
    path.quadraticBezierTo(0, size.height, cornerSize, size.height);
    path.lineTo(size.width - cornerSize, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - cornerSize);
    path.lineTo(size.width, diagonalHeight + cornerSize);
    path.quadraticBezierTo(size.width, diagonalHeight, size.width - cornerSize,
        diagonalHeight * .9);
    path.lineTo(cornerSize * 2, cornerSize);
    path.quadraticBezierTo(0, 0, 0, cornerSize * 1.5);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

// Create item List for  Trend list
Widget buildItemTrendList(Shoe shoe) {
  ShoeCardController shoeControll = Get.find();

  return ClipPath(
    clipper: AppClipper(15, 120),
    child: Container(
      width: 250,
      color: identical(int.parse(shoe.colors[0]), Colors.white.value)
          ? Colors.lightBlue.shade50
          : Color(int.parse(shoe.colors[0])),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(child: SizedBox()),
                AutoSizeText(shoe.name,
                    textAlign: TextAlign.end,
                    minFontSize: 18,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: (identical(int.parse(shoe.colors[0]),
                                  Colors.white.value) ||
                              identical(int.parse(shoe.colors[0]),
                                  Colors.yellow.value))
                          ? Colors.black
                          : Colors.white,
                      fontSize: 22,
                    )),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.only(right: 22.0),
                  child: Text(shoe.price,
                      style: TextStyle(
                          color: (identical(int.parse(shoe.colors[0]),
                                      Colors.white.value) ||
                                  identical(int.parse(shoe.colors[0]),
                                      Colors.yellow.value))
                              //Color(int.parse(trendShoe[index].colors[0])) == Colors.white.value
                              ? Colors.black
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Obx(() {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    shoeControll.shoe = shoe;
                    shoeControll.cFav();
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.red)),
                    child: Center(
                        child: FlareActor(
                      'assets/Like.flr',
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                      animation: shoe.isFav.value,
                    )),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    ),
  );
}

// Build item for cart list
Widget buildItemCartList(int index) {
  BagController bagControll = Get.find();
  return Container(
    width: 200,
    margin: const EdgeInsets.only(right: 16),
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: ClipPath(
              clipper: AppClipper(10, 100),
              child: Container(
                color: Colors.lightBlue.shade50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(bagControll.itemList[index].shoeName,
                        style: const TextStyle(fontSize: 18)),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(bagControll.itemList[index].shoePrice,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 19,
                            backgroundColor: Color(int.parse(
                                bagControll.itemList[index].shoeColor)),
                          ),
                          const Spacer(),
                          Text(bagControll.itemList[index].shoeSize),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
        Positioned(
          bottom: 110,
          left: 10,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Image.network(bagControll.itemList[index].shoeImg),
          ),
        ),
        Positioned(
          left: 0.0,
          top: 10.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 10),
            child: InkWell(
              onTap: () {
                bagControll.deleteShoeAsCart(index);
              },
              child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.red)),
                  child: const Center(
                      child: Icon(Icons.delete, size: 15, color: Colors.red))),
            ),
          ),
        ),
      ],
    ),
  );
}
