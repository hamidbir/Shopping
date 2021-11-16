import 'dart:ui';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_shoe/controller/auth_controller.dart';
import 'package:shopping_shoe/utils/color_const.dart';
import 'package:shopping_shoe/view/pages/admin_panel.dart';
import 'package:shopping_shoe/view/pages/auth/sign_up.dart';
import 'package:shopping_shoe/view/pages/main_screen.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> with TickerProviderStateMixin {
  static const String signUp = 'هنوز ثبت نام نکرده اید؟ ثبت نام';
  static const String login = 'ورود';
  static const String emailHint = 'ایمیل';
  static const String passwordHint = 'پسورد';
  static const String authFail = 'احرازهویت شکست خورد';
  static FocusNode emailNode = FocusNode();
  static FocusNode passNode = FocusNode();
  //late AnimationController animationController;
  //late Animation animation;

  // @override
  // void initState() {
  //   animationController =
  //       AnimationController(vsync: this, duration: const Duration(seconds: 20));
  //   animation =
  //       CurvedAnimation(parent: animationController, curve: Curves.linear)
  //         ..addListener(() {
  //           setState(() {});
  //         })
  //         ..addStatusListener((animStatus) {});
  //   animationController.repeat(reverse: true);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    return Scaffold(body: SafeArea(child: Obx(() {
      return authController.isLoading.value
          ? showLoading(context)
          : Stack(
              children: [
                Image.asset(
                  'assets/images/back4.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  //alignment: FractionalOffset(animation.value, 0),
                ),
                Center(
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0.7, sigmaY: 0.7),
                      child: Container(
                        width: 400,
                        height: 400,
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
                                login,
                                style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstants.dark),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.offAll(SignUp());
                                },
                                child: const Text(
                                  signUp,
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
                                  cursorColor: ColorConstants.white,
                                  style: const TextStyle(
                                      fontFamilyFallback: ['EFont']),
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 0.0),
                                      ),
                                      hintText: emailHint,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 0.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorConstants.primary,
                                            width: 0.0),
                                      ))),
                              const SizedBox(height: 5),
                              TextField(
                                  style: const TextStyle(
                                      fontFamilyFallback: ['EFont']),
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
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorConstants.primary,
                                            width: 0.0),
                                      ))),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 55,
                                child: ElevatedButton(
                                    onPressed: () async {
                                      await authController.signIn()
                                          ? authController.getAdmin()
                                              ? Get.offAll(AdminPanel())
                                              : Get.offAll(const MainScreen())
                                          : Get.snackbar(authFail,
                                              authController.errorText.value);
                                    },
                                    child: const Text(
                                      login,
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
    })));
  }
}

Widget showLoading(BuildContext context) {
  Future.delayed(
      Duration.zero,
      () => showDialog(
          context: context,
          builder: (_) => const Dialog(
              backgroundColor: Colors.transparent,
              child: FlareActor(
                'assets/loading.flr',
                animation: 'walking',
              ))));
  return const SizedBox();
}
