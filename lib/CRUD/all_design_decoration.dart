import 'package:flutter/material.dart';

InputDecoration formDecoration(String label,Widget icon){
  return InputDecoration(
    prefixIcon: icon,
      labelText: label,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20)
      )

  );
}

BoxDecoration buttonDecoration(){
  return BoxDecoration(
      color: Colors.blueGrey[200],
      borderRadius: BorderRadius.circular(20),
      shape: BoxShape.rectangle
  );
}

