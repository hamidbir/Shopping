import 'package:get/get.dart';
import 'package:shopping_shoe/repository/cloud_function.dart';
import 'package:shopping_shoe/utils/storage.dart';

class MyProfileController extends GetxController {
  var isLoading = true.obs;
  var userName = ''.obs;
  var email = ''.obs;
  var isNetworkError = false.obs;

  @override
  void onInit() {
    super.onInit();
    getUserDetail();
  }

  getUserDetail() async {
    isLoading.value = true;
    isNetworkError.value = false;
    //   print(Storage().getUid());
    try {
      final userdetails =
          await CloudFunction().getUserDetail(Storage().getUid());

      userName.value = userdetails['userName'];
      email.value = userdetails['email'];
    } on Exception catch (e) {
      print('error is ' + e.toString());
      isNetworkError.value = true;
    } catch (e) {
      isNetworkError.value = true;
    }
    isLoading.value = false;
  }
}
