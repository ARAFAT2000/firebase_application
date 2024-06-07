import 'package:flutter/material.dart';

import '../../View_Model/splass Services/splass_services.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplassService service =SplassService();
  @override
  void initState() {
    // TODO: implement initState
    service.isLoggedIn(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Image(image: AssetImage('assets/images/logo.jpg')),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 20),
                child: Center(child: Text('Student App' ,
                  style: TextStyle( fontSize: 40, fontWeight: FontWeight.w700),)),
              )
            ],
          )
      ),
    );
  }
}