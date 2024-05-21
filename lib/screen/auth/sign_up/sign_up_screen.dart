import 'package:firebase_application/utils/button.dart';
import 'package:firebase_application/utils/modify_text.dart';
import 'package:firebase_application/utils/textform-field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../sign_in/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
       body: Padding(
         padding: const EdgeInsets.only(top: 30,right: 25,left: 25),
         child: SingleChildScrollView(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           CircleAvatar(
             radius: 75,
             child:  Image.asset('assets/images/email.jpg',fit: BoxFit.fill,),
           ),
           SizedBox(
             height: size.height/45,
           ),
           Card(
             elevation: 5,
             color: Colors.white,
              shadowColor: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: AuthPagedecoration('username', Icon(Icons.person))
                ),
              ),
           ),
           SizedBox(
             height: size.height/45,
           ),
           Card(
             elevation: 5,
             color: Colors.white,
             shadowColor: Colors.blue,
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: TextFormField(
                   decoration: AuthPagedecoration('email', Icon(Icons.email_outlined))
               ),
             ),
           ),
           SizedBox(
             height: size.height/45,
           ),
           Card(
           color: Colors.white,
             shadowColor: Colors.blue,
             elevation: 5,
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: TextFormField(
                   decoration: AuthPagedecoration('password', Icon(Icons.password))
               ),
             ),
           ),
           SizedBox(
             height: size.height/17,
           ),
       
           RoundButtonadd(
               title: 'Sign Up',
               onpress: (){},
               color: Colors.green,
               textcolor: Colors.white),
           Padding(
             padding: const EdgeInsets.only(left: 30),
             child: Row(
               children: [
                 ModifyText(text: 'Already have an account ?', size: 15),
                 TextButton(onPressed: (){
                   Get.to(SignInScreen());
                 }, child: Text('Sign In'))
               ],
             ),
           ),
           SizedBox(
             height: size.height/25,
           ),
           ModifyText(text: 'or ', size: 15),
      
          Row(
        mainAxisAlignment: MainAxisAlignment.center,
      
            children: [
              Image.asset('assets/images/email.jpg',height: 35,width: 35,),
              Image.asset('assets/images/facebook.jpg',height: 55,width: 55,)
            ],
          )
           
         ],
       ),
         ),
       ),
      ),
    );
  }
}
