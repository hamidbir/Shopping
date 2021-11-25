import 'package:flutter/material.dart';

class CounterShoe extends StatelessWidget {
  const CounterShoe(
      {Key? key,
      required this.count,
      required this.upperClick,
      required this.downerClick})
      : super(key: key);
  final int count;
  final void Function()? upperClick;
  final void Function()? downerClick;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
            onPressed: upperClick,
            icon: const Icon(
              Icons.arrow_drop_up_rounded,
              color: Colors.black,
              size: 18,
            )),
        const SizedBox(
          height: 10,
        ),
        Text(count.toString()),
        const SizedBox(
          height: 10,
        ),
        IconButton(
            onPressed: downerClick,
            icon: const Icon(
              Icons.arrow_drop_down_rounded,
              color: Colors.black,
              size: 18,
            )),
      ],
    );
  }
}
