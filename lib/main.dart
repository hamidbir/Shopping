import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shopping_shoe/view/pages/admin_panel.dart';
import 'package:shopping_shoe/view/pages/auth/login.dart';
import 'package:shopping_shoe/view/pages/auth/sign_up.dart';
import 'package:shopping_shoe/view/pages/cart/cart_screen.dart';
import 'package:shopping_shoe/view/pages/detail/detail_shoe.dart';
import 'package:shopping_shoe/view/pages/home/main_screen.dart';
import 'package:shopping_shoe/view/pages/profile/profile_view.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //To initialize FlutterFire, call the initializeApp method on the Firebase class:
    //The method is asynchronous and returns a Future, so we need to ensure it has completed
    //before displaying  main application
    final Future<FirebaseApp> _initialztion = Firebase.initializeApp();
    return FutureBuilder<FirebaseApp>(
        future: _initialztion,
        builder: (context, snapshot) {
          //Package get:
          // GetMaterialApp is necessary for routes, snackbars, internationalization, bottomSheets,
          // dialogs, and high-level apis related to routes and absence of context.
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            //Internationalized apps that require translations for one of
            //the locales listed in GlobalMaterialLocalizations should specify
            //this parameter and list the supportedLocales that the application can handle.
            localizationsDelegates: const [
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
            ],
            locale: const Locale("fa", "IR"),
            title: 'کفش هزارپا',
            theme: ThemeData(
              fontFamily: 'MainFont',
              primarySwatch: Colors.cyan,
            ),
            // home: const Login(),
            initialRoute: '/Login',
            getPages: [
              GetPage(
                  name: '/Login',
                  page: () => const Login(),
                  transition: Transition.zoom),
              GetPage(
                  name: '/signup',
                  page: () => const SignUp(),
                  transition: Transition.zoom),
              GetPage(
                  name: '/',
                  page: () => const MainScreen(),
                  transition: Transition.zoom),
              GetPage(name: '/detail_shoe', page: () => const DetailShoe()),
              GetPage(
                  name: '/cart',
                  page: () => const CartScreen(),
                  transition: Transition.zoom),
              GetPage(
                  name: '/my_profile',
                  page: () => const ProfileView(),
                  transition: Transition.zoom),
              GetPage(
                  name: '/admin_panel',
                  page: () => const AdminPanel(),
                  transition: Transition.zoom),
            ],
          );
        });
  }
}
