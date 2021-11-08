import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:shopping_shoe/view/pages/home_page.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.blue,
          child: Column(
            children: [
              Expanded(flex: 4, child: Container(color: Colors.pink)),
              Expanded(
                  flex: 6,
                  child:
                      Container(color: Colors.yellow, child: const HomePage())),
            ],
          )),
    );
  }
}
