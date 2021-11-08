import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/auth_controller.dart';
import 'package:shopping_shoe/utils/color_const.dart';
import 'package:shopping_shoe/view/pages/auth/login.dart';
import 'package:shopping_shoe/view/pages/home_page.dart';
import 'package:shopping_shoe/view/pages/landing_page.dart';
import 'package:shopping_shoe/view/pages/upload_shoe_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin {
  static const String login = ' ثبت نام کرده اید؟ ورود';
  static const String signUp = 'ثبت نام';
  static const String nameHint = 'نام کاربری';
  static const String emailHint = 'ایمیل';
  static const String passwordHint = 'پسورد';
  static const String authFail = 'احرازهویت شکست خورد';
  static FocusNode nameNode = FocusNode();
  static FocusNode emailNode = FocusNode();
  static FocusNode passNode = FocusNode();
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animStatus) {});
    animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    return Scaffold(body: SafeArea(child: Obx(() {
      return authController.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Image.network(
                  'https://www.wallpaperup.com/uploads/wallpapers/2015/02/12/620597/cd4fcf4cf8534583a2ad4446ba926235-700.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  alignment: FractionalOffset(animation.value, 0),
                ),
                Center(
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                      child: Container(
                        width: 400,
                        height: 350,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200.withOpacity(0.5),
                        ),
                        child: SingleChildScrollView(
                            child: Padding(
                          padding: const EdgeInsets.all(38.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                signUp,
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstants.dark),
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  Get.offAll(Login());
                                },
                                child: const Text(
                                  login,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstants.dark),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                  focusNode: nameNode,
                                  onEditingComplete: () =>
                                      FocusScope.of(context).requestFocus(),
                                  textInputAction: TextInputAction.next,
                                  controller: authController.usernameController,
                                  cursorColor: ColorConstants.white,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0.0),
                                    ),
                                    hintText: nameHint,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0.0),
                                    ),
                                    // border: OutlineInputBorder(
                                    //   borderSide: BorderSide(
                                    //       color: ColorConstants.primary,
                                    //       width: 0.0),
                                    // )
                                  )),
                              const SizedBox(height: 10),
                              TextField(
                                  focusNode: emailNode,
                                  onEditingComplete: () =>
                                      FocusScope.of(context).requestFocus(),
                                  textInputAction: TextInputAction.next,
                                  controller: authController.emailController,
                                  cursorColor: ColorConstants.white,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0.0),
                                    ),
                                    hintText: emailHint,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0.0),
                                    ),
                                    // border: OutlineInputBorder(
                                    //   borderSide: BorderSide(
                                    //       color: ColorConstants.primary,
                                    //       width: 0.0),
                                    // )
                                  )),
                              const SizedBox(height: 10),
                              TextField(
                                  focusNode: passNode,
                                  textInputAction: TextInputAction.next,
                                  obscureText: true,
                                  onEditingComplete: () =>
                                      FocusScope.of(context).requestFocus(),
                                  controller: authController.passwordController,
                                  cursorColor: ColorConstants.white,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0.0),
                                    ),
                                    hintText: passwordHint,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0.0),
                                    ),
                                    // border: OutlineInputBorder(
                                    //   borderSide: BorderSide(
                                    //       color: ColorConstants.primary,
                                    //       width: 0.0),
                                    // )
                                  )),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                  onPressed: () async {
                                    await authController.signUp()
                                        ? Get.offAll(const LandingPage())
                                        : Get.snackbar(authFail,
                                            authController.errorText.value);
                                  },
                                  child: const Text(signUp))
                            ],
                          ),
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            );
    })));
  }
}
