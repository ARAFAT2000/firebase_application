import 'dart:async';
import 'package:firebase_application/View_Model/splass%20Services/sesson_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../View/auth/sign_in/sign_in_screen.dart';
import '../../View/auth/sign_up/sign_up_screen.dart';





class SplassService{

  void isLoggedIn(BuildContext context){
    FirebaseAuth  _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;

    if(user !=null){

      SessionController().userId=user.uid.toString();

      Timer(Duration(seconds: 3), () =>
          Get.to(SignUpScreen())
      );
    }else{
      Timer(Duration(seconds: 3), () =>
          Get.to(SignInScreen())
      );
    }



  }


}