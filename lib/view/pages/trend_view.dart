import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/shoe_card_controller.dart';
import 'package:shopping_shoe/model/shoe.dart';
import 'package:shopping_shoe/utils/color_const.dart';

List<Shoe> trendShoe = [
  Shoe(
      id: '1',
      name: 'کفش یک ',
      category: ['مجلسی', 'زنانه'],
      imageURL: ['assets/images/s1.png'],
      price: 210000.toString(),
      colors: ['4278190080'],
      size: ['39', '40'],
      description: 'good'),
  Shoe(
      id: '2',
      name: 'کفش دو',
      category: ['مجلسی', 'زنانه'],
      imageURL: ['assets/images/s2.png'],
      price: 210000.toString(),
      colors: ['4293467747'],
      size: ['39', '40'],
      description: 'good'),
  Shoe(
      id: '3',
      name: 'کفش سه',
      category: ['مجلسی', 'زنانه'],
      imageURL: ['assets/images/s3.png'],
      price: 210000.toString(),
      colors: ['4288423856'],
      size: ['39', '40'],
      description: 'good'),
  Shoe(
      id: '4',
      name: 'کفش چهار',
      category: ['مجلسی', 'زنانه'],
      imageURL: ['assets/images/s5.png'],
      price: 210000.toString(),
      colors: [Colors.blue.value.toString()],
      size: ['39', '40'],
      description: 'good'),
  Shoe(
      id: '5',
      name: 'کفش پنج',
      category: ['مجلسی', 'زنانه'],
      imageURL: ['assets/images/s4.png'],
      price: 210000.toString(),
      colors: ['4294967295'],
      size: ['39', '40'],
      description: 'good'),
  Shoe(
      id: '6',
      name: 'کفش شش',
      category: ['مجلسی', 'زنانه'],
      imageURL: ['assets/images/s6.png'],
      price: 210000.toString(),
      colors: [Colors.blue.value.toString()],
      size: ['39', '40'],
      description: 'good'),
];

class TrendView extends StatelessWidget {
  const TrendView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: trendShoe.length,
          itemBuilder: (context, index) {
            return Container(
              width: 200,
              margin: const EdgeInsets.only(right: 16),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: _buildBackground(index),
                  ),
                  Positioned(
                      bottom: 80,
                      right: 10,
                      child: SizedBox(
                          width: 150,
                          height: 150,
                          child: Image.asset(trendShoe[index].imageURL[0]))),
                ],
              ),
            );
          }),
    );
  }

  Widget _buildBackground(int index) {
    ShoeCardController shoeControll = Get.find();

    return ClipPath(
      clipper: AppClipper(15, 150),
      child: Container(
        // decoration: BoxDecoration(
        // border: Border.all(
        //     width: identical(int.parse(trendShoe[index].colors[0]),
        //             Colors.white.value)
        //         //trendShoe[index].colors[0] == '4294967295'
        //         ? 1
        //         : 0.5,
        //     color: Colors.black)),
        width: 200,
        color:
            identical(int.parse(trendShoe[index].colors[0]), Colors.white.value)
                ? Colors.lightBlue.shade50
                : Color(int.parse(trendShoe[index].colors[0])),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.shower, size: 40, color: Colors.white),
                  const Expanded(child: SizedBox()),
                  Container(
                    width: 125,
                    padding: const EdgeInsets.only(right: 22.0),
                    child: Text(trendShoe[index].name,
                        style: TextStyle(
                            color: identical(
                                    int.parse(trendShoe[index].colors[0]),
                                    Colors.white.value)
                                //trendShoe[index].colors[0] == '4294967295'
                                ? Colors.black
                                : Colors.white,
                            fontSize: 22)),
                  ),
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 22.0),
                    child: Text(trendShoe[index].price,
                        style: TextStyle(
                            color: identical(
                                    int.parse(trendShoe[index].colors[0]),
                                    Colors.white.value)
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
                      shoeControll.shoe = trendShoe[index];
                      shoeControll.cFav();
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstants.white,
                          border: Border.all(color: Colors.red)),
                      child: Center(
                          child: FlareActor(
                        'assets/Like.flr',
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                        animation: trendShoe[index].isFav.value,
                      )),
                    ),
                  ),
                );
              }),
              // child: Container(
              //   width: 50,
              //   height: 50,
              //   decoration: const BoxDecoration(
              //       color: Colors.greenAccent,
              //       borderRadius: BorderRadius.only(
              //         topRight: Radius.circular(10),
              //       )),
              //   child: const Center(
              //     child: Icon(Icons.add, color: Colors.white),
              //   ),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}

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
