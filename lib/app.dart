
import 'package:firebase_application/dashboard/dasboard.dart';
import 'package:firebase_application/screen/NoticeScreen.dart';
import 'package:firebase_application/screen/home_screen.dart';
import 'package:firebase_application/screen/image_screen.dart';
import 'package:firebase_application/screen/profile_screen.dart';
import 'package:firebase_application/screen/notice_board.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'screen/add_screen.dart';
import 'screen/auth/sign_in/sign_in_screen.dart';
import 'screen/auth/sign_up/sign_up_screen.dart';
import 'screen/profile_screen.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: HomeScreen()
    );
  }
}