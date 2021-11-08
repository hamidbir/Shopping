import 'package:get/get.dart';

class BottomNavBarController extends GetxController {
  final _currentIndex = 0.obs;
  set currentIndex(index) => _currentIndex.value = index;
  get currentIndex => _currentIndex.value;

  void changeIndex(int index) {
    currentIndex = index;
  }
}
