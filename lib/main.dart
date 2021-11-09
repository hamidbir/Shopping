import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopping_shoe/view/pages/admin_panel.dart';
import 'package:shopping_shoe/view/pages/auth/login.dart';
import 'package:shopping_shoe/view/pages/main_screen.dart';
import 'package:shopping_shoe/view/pages/trend_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // get storage init initilize
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialztion = Firebase.initializeApp();
    return FutureBuilder<FirebaseApp>(
        future: _initialztion,
        builder: (context, snapshot) {
          return GetMaterialApp(
              localizationsDelegates: const [
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale(
                    "fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
              ],
              locale: const Locale("fa", "IR"),
              title: 'کفش گلریز',
              theme: ThemeData(
                fontFamily: 'MainFont',
                primarySwatch: Colors.cyan,
              ),
              home: //const TrendView(),
                  Login());
          //const MainScreen()); //const LandingPage()), // AdminPanel()),
        });
  }
}
