import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

Widget loadingWidget({bool isBack = false}) {
  return Center(
    child: isBack
        ? Container(
            width: 250,
            height: 250,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
            child: showShoe())
        : Container(
            color: Colors.transparent,
            width: 250,
            height: 250,
            child: showShoe()),
  );
}

Widget showShoe() {
  return const FlareActor(
    'assets/shoe.flr',
    animation: 'on',
  );
}
