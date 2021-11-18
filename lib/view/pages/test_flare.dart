import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class TestFlare extends StatelessWidget {
  const TestFlare({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: FlareActor(
        'assets/shoe.flr',
        alignment: Alignment.center,
        animation: 'on',
        fit: BoxFit.contain,
      ),
    ));
  }
}
