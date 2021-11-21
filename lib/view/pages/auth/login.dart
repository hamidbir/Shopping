import 'dart:ui';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/auth_controller.dart';
import 'package:shopping_shoe/utils/color_const.dart';
import 'package:shopping_shoe/utils/constants.dart';
import 'package:shopping_shoe/utils/route_transition.dart';
import 'package:shopping_shoe/view/pages/admin_panel.dart';
import 'package:shopping_shoe/view/pages/auth/sign_up.dart';
import 'package:shopping_shoe/view/pages/home/main_screen.dart';
import 'package:shopping_shoe/view/widgets/loading_widget.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  static FocusNode emailNode = FocusNode();
  static FocusNode passNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Scaffold(body: Obx(() {
      return Stack(
        children: [
          //Background Image
          Image.asset(
            'assets/images/back4.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: authController.isLoading.value
                ?
                //Loading UI
                loadingWidget(isBack: true)
                :
                //blur Contanier
                ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0.7, sigmaY: 0.7),
                      child: Container(
                        width: 400,
                        height: 400,
                        //Colors blur
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
                                Constants.login,
                                style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstants.dark),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.offNamed('/signup');
                                  // Navigator.of(context).pushReplacement(
                                  //     SizeRoute(page: SignUp()));
                                },
                                child: const Text(
                                  Constants.signUp,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstants.dark),
                                ),
                              ),
                              const SizedBox(height: 20),
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
                                            color: Color.fromRGBO(
                                                153, 146, 132, 1)),
                                      ),
                                      hintText: Constants.emailHint,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.0,
                                            color:
                                                Color.fromRGBO(16, 86, 82, 1)),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorConstants.primary,
                                            width: 0.0),
                                      ))),
                              const SizedBox(height: 5),
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
                                            color: Color.fromRGBO(
                                                153, 146, 132, 1)),
                                      ),
                                      hintText: Constants.passwordHint,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.0,
                                            color:
                                                Color.fromRGBO(16, 86, 82, 1)),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorConstants.primary,
                                            width: 0.0),
                                      ))),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 55,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: const Color.fromRGBO(
                                            185, 22, 70, 1)),
                                    onPressed: () async {
                                      //Check user is admin or not
                                      await authController.signIn()
                                          ? authController.getAdmin()
                                              ? Get.toNamed('/admin_panel')
                                              : Get.toNamed('/')
                                          : Get.snackbar(Constants.authFail,
                                              authController.errorText.value);
                                    },
                                    child: const Text(
                                      Constants.login,
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(240, 228, 215, 1)),
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
