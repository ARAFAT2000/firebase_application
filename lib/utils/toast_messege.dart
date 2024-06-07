import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constant/constant.dart';

class toastmessege{

  //work on toast messege

  static void toastnotice(String messege){
    Fluttertoast.showToast(msg: messege,
        backgroundColor: AppColors.primaryTextTextColor,
        textColor: AppColors.whiteColor,
        fontSize: 16
    );

  }
}