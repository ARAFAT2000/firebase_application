import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SplassService{


  void isLoggedIn(BuildContext context){
    FirebaseAuth  _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;

    if(user !=null){



      // Timer(Duration(seconds: 3), () =>
      //     Navigator.pushNamed(context, RouteName.loginScreen)
      // );
    }else{
      // Timer(Duration(seconds: 3), () =>
      //     Navigator.pushNamed(context, RouteName.loginScreen)
      // );
    }



  }

}