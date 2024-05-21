
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundButtonadd extends StatelessWidget {

  final String title;
  final VoidCallback onpress;
  final Color color ,textcolor;
  final bool loading;
  const RoundButtonadd({super.key,
    required this.title,
    required this.onpress,
    this.loading=false,
    required this.color,
    required this.textcolor,

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
        Text(title, style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 16,color:textcolor),)),
      ),
    );
  }

}