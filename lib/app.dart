import 'package:firebase_application/AUTH/otp_varify.dart';
import 'package:firebase_application/AUTH/phone_number_auth.dart';
import 'package:firebase_application/CRUD/fetchdata_screen.dart';
import 'package:firebase_application/CRUD/write_data_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  RegisterPage(),
    );
  }
}