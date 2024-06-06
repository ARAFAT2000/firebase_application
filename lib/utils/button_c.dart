import 'package:flutter/material.dart';

import '../constant/constant.dart';

class RoundButton extends StatelessWidget {

  final String title;
  final VoidCallback onpress;
  final Color color ,textcolor;
  final bool loading;
  const RoundButton({super.key,
    required this.title,
    required this.onpress,
    this.loading=false,
    this.color =  AppColors.primaryColor,
    this.textcolor = AppColors.whiteColor
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ?null : onpress,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: color,
        ),
        child: Center(child:loading? CircularProgressIndicator(color: Colors.white,strokeWidth: 2.0,):
        Text(title, style:TextStyle(fontWeight: FontWeight.bold))),
      ),
    );
  }

}