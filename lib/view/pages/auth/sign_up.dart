import 'dart:ui';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/auth_controller.dart';
import 'package:shopping_shoe/utils/color_const.dart';
import 'package:shopping_shoe/utils/constants.dart';
import 'package:shopping_shoe/utils/route_transition.dart';
import 'package:shopping_shoe/view/pages/auth/login.dart';
import 'package:shopping_shoe/view/pages/landing_page.dart';
import 'package:shopping_shoe/view/pages/home/main_screen.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  static FocusNode nameNode = FocusNode();
  static FocusNode emailNode = FocusNode();
  static FocusNode passNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    return Scaffold(body: Obx(() {
      return Stack(
        children: [
          // Image Backgroud
          Image.asset(
            'assets/images/back4.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: authController.isLoading.value
                ? Container(
                    width: 250,
                    height: 250,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    // Package Flare for loading
                    child: const FlareActor(
                      'assets/shoe.flr',
                      animation: 'on',
                      fit: BoxFit.contain,
                    ))
                : ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                      child: Container(
                        width: 400,
                        height: 500,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(251, 243, 228, 0.9)),
                        child: SingleChildScrollView(
                            child: Padding(
                          padding: const EdgeInsets.all(38.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                Constants.signUpText,
                                style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstants.dark),
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  Get.offNamed('/Login');
                                },
                                child: const Text(
                                  Constants.loginText,
                                  style: TextStyle(
                                      fontSize: 20,
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
                                  cursorColor:
                                      const Color.fromRGBO(185, 22, 70, 1),
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.0,
                                          color:
                                              Color.fromRGBO(153, 146, 132, 1)),
                                    ),
                                    hintText: Constants.nameHintText,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.0,
                                          color: Color.fromRGBO(16, 86, 82, 1)),
                                    ),
                                  )),
                              const SizedBox(height: 10),
                              TextField(
                                  focusNode: emailNode,
                                  onEditingComplete: () =>
                                      FocusScope.of(context).requestFocus(),
                                  textInputAction: TextInputAction.next,
                                  controller: authController.emailController,
                                  cursorColor:
                                      const Color.fromRGBO(185, 22, 70, 1),
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.0,
                                          color:
                                              Color.fromRGBO(153, 146, 132, 1)),
                                    ),
                                    hintText: Constants.emailHintText,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.0,
                                          color: Color.fromRGBO(16, 86, 82, 1)),
                                    ),
                                  )),
                              const SizedBox(height: 10),
                              TextField(
                                  focusNode: passNode,
                                  textInputAction: TextInputAction.next,
                                  obscureText: true,
                                  onEditingComplete: () =>
                                      FocusScope.of(context).requestFocus(),
                                  controller: authController.passwordController,
                                  cursorColor:
                                      const Color.fromRGBO(185, 22, 70, 1),
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.0,
                                          color:
                                              Color.fromRGBO(153, 146, 132, 1)),
                                    ),
                                    hintText: Constants.passwordHintText,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.0,
                                          color: Color.fromRGBO(16, 86, 82, 1)),
                                    ),
                                  )),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 55,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: const Color.fromRGBO(
                                            185, 22, 70, 1)),
                                    onPressed: () async {
                                      //Check user sign up and info correct or not
                                      await authController.signUp()
                                          ? Get.toNamed('/')
                                          : Get.snackbar(Constants.authFailText,
                                              authController.errorText.value);
                                    },
                                    child: const Text(
                                      Constants.signUpText,
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: ColorConstants.dark),
                                    )),
                              )
                            ],
                          ),
                        )),
                      ),
                    ),
                  ),
          ),
        ],
      );
    }));
  }
}
