import 'package:flutter/material.dart';

class ProfileReuseable extends StatelessWidget {
  String name,value;
  IconData icon;
  ProfileReuseable({required this.name, required this.value,required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
     ListTile(
       //style: TextStyle(fontSize:18,fontWeight: FontWeight.bold
       title: Text(name,),
       leading: Icon(icon,),
       trailing: Text(value),
     ),
        Divider(
        )

      ],
    );
  }
}