import 'package:flutter/material.dart';

InputDecoration TextFieldDesign(String label){

  return InputDecoration(
    contentPadding: EdgeInsets.only(left: 20,top: 45,right: 20),

    hintText: label,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20))
    ),
    fillColor: Colors.green
  );
}


InputDecoration AuthPagedecoration(String label, Widget icon ){
  return InputDecoration(
      hintText: label,
      prefixIcon: icon,
      border: InputBorder.none
  );
}