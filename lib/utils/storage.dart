import 'package:get_storage/get_storage.dart';

//A fast, extra light and synchronous key-value in memory, which backs up data to disk at each operation.
//It is written entirely in Dart and easily integrates with Get framework of Flutter.
class Storage {
  //use GetStorage through an instance or use directly GetStorage()
  static final box = GetStorage();

  //read login value
  bool getLoginValue() {
    //To read values you use read
    if (box.read('login') == null || box.read('login') == false) {
      return false;
    }

    return true;
  }

  //write login value
  Future<void> setLoginValue() async {
    //To write information you must use write :
    await box.write('login', true);
  }

  //read uid
  String getUid() {
    return box.read('uid');
  }

  //write uid
  Future<void> setUid(String uid) async {
    return box.write('uid', uid);
  }
}
