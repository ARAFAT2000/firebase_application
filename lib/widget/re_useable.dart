import 'package:flutter/material.dart';

class Reuseable extends StatelessWidget {
  String name;
  String value;
  Reuseable({required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name),
        Text(value),

      ],
    );
  }
}