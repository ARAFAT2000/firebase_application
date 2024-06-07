import 'package:flutter/material.dart';

class ExamReuseable extends StatelessWidget {
  String name,value;

  ExamReuseable({required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ListTile(
          title: Text(name,),
          trailing: Text(value),
        ),


      ],
    );
  }
}