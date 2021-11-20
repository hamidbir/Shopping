import 'package:flutter/material.dart';

class Constants {
  // These lists for Admin panel
  static List<String> taskCategoryList = [
    'چرم',
    'اسپورت',
    'مردانه',
    'زنانه',
    'بچگانه',
    'ورزشی',
    'صندل و راحتی'
  ];
  static List<String> shoeColorList = [
    'قرمز',
    'آبی',
    'مشکی ',
    'قهوه ای ',
    'سبز',
    'خاکستری',
    'زرد',
    'بنفش',
    'صورتی',
    'نارنجی',
    'فیروزه ای',
    'زرشکی',
  ];
  static List<String> colorShoe = [
    Colors.black.value.toString(),
    Colors.white.value.toString(),
    Colors.brown.value.toString(),
    Colors.brown.shade900.value.toString(),
    Colors.red.value.toString(),
    Colors.blue.value.toString(),
    Colors.green.value.toString(),
    Colors.yellow.value.toString(),
    Colors.orange.value.toString(),
    Colors.orange.shade900.value.toString(),
    Colors.amber.value.toString(),
    Colors.grey.value.toString(),
    Colors.blueGrey.value.toString(),
    Colors.purple.value.toString(),
    Colors.pink.value.toString(),
    Colors.cyanAccent.value.toString(),
    Colors.teal.value.toString(),
    Colors.lime.value.toString(),
    Colors.lightGreen.value.toString(),
    Colors.indigo.value.toString(),
  ];
  // Const for Login page
  static const String signUp = 'هنوز ثبت نام نکرده اید؟ ثبت نام';
  static const String login = 'ورود';
  static const String emailHint = 'ایمیل';
  static const String passwordHint = 'پسورد';
  static const String authFail = 'احرازهویت شکست خورد';
  // Const for sign up page
  static const String loginText = ' ثبت نام کرده اید؟ ورود';
  static const String signUpText = 'ثبت نام';
  static const String nameHintText = 'نام کاربری';
  static const String emailHintText = 'ایمیل';
  static const String passwordHintText = 'پسورد';
  static const String authFailText = 'احرازهویت شکست خورد';
}
