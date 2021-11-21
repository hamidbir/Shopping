import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/repository/cloud_function.dart';

class AuthController extends GetxController {
  var errorText = ''.obs;
  var isVerified = false.obs;
  var isLoading = false.obs;
  var isAdmin = false.obs;
  late final userId;

  // Textfield controller
  late TextEditingController emailController =
      TextEditingController(text: 'abc@gmail.com');
  late TextEditingController passwordController =
      TextEditingController(text: '123456');
  late TextEditingController usernameController;

  // instance for Firebase Authentication
  static final firebaseAuth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    usernameController = TextEditingController();
  }

  Future<bool> signIn() async {
    isLoading.value = true;
    if (GetUtils.isEmail(emailController.text) &&
        passwordController.text.isNotEmpty) {
      try {
        final UserCredential userCredential =
            await firebaseAuth.signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        final userdetails = await CloudFunction()
            .getUserDetail(/*Storage().getUid()*/ userCredential.user!.uid);
        if (userdetails['role'] == 'admin') {
          isAdmin.value = true;
        }
        userId = userCredential.user!.uid;
        // Storage().setLoginValue();
        // await Storage().setUid(userCredential.user!.uid);

        isLoading.value = false;
        return true;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          errorText.value = 'کاربری با این ایمیل یافت نشد ';
          isLoading.value = false;
          return false;
        } else if (e.code == 'wrong-password') {
          errorText.value = 'رمز عبور اشتباه است';
          isLoading.value = false;
          return false;
        }
      } on Exception {
        errorText.value = 'اوپس. مشکلی رخ داد :(';
        isLoading.value = false;
        return false;
      } catch (e) {
        errorText.value = 'اوپس. مشکلی رخ داد :(';
        print(e.toString());
        isLoading.value = false;
        return false;
      }
    }
    errorText.value = 'لطفا ایمیل صحیح و رمزعبور را وارد کنید';
    isLoading.value = false;
    return false;
  }

  Future<bool> signUp() async {
    isLoading.value = true;
    if (GetUtils.isEmail(emailController.text) &&
        passwordController.text.isNotEmpty) {
      try {
        final UserCredential userCredential =
            await firebaseAuth.createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        await CloudFunction().saveUser(userCredential.user!.uid,
            emailController.value.text, usernameController.value.text);
        userId = userCredential.user!.uid;
        // await Storage().setLoginValue();
        // await Storage().setUid(userCredential.user!.uid);
        isLoading.value = false;
        return true;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          errorText.value = 'رمز عبور ضعیف است';
          isLoading.value = false;
          return false;
        } else if (e.code == 'email-already-use') {
          errorText.value = 'کاربری با این ایمیل ثبت شده است';
          isLoading.value = false;
          return false;
        }
      } on Exception {
        errorText.value = 'اوپس. مشکلی رخ داد :(';
        isLoading.value = false;
        return false;
      } catch (e) {
        errorText.value = 'اوپس. مشکلی رخ داد :(';
        isLoading.value = false;
        return false;
      }
    }
    errorText.value = 'لطفا ایمیل صحیح و رمزعبور را وارد کنید';
    isLoading.value = false;
    return false;
  }

  Future<void> varifeyUser() async {
    await firebaseAuth.currentUser!.reload();
    if (firebaseAuth.currentUser!.emailVerified) {
      isVerified.value = true;
    }
  }

  bool getAdmin() {
    return isAdmin.value;
  }
}
