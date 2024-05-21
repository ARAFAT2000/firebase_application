import 'package:firebase_application/screen/auth/sign_up/sign_up_screen.dart';
import 'package:firebase_application/utils/button.dart';
import 'package:firebase_application/utils/modify_text.dart';
import 'package:firebase_application/utils/textform-field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                  height: size.height/75,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ModifyText(text: 'forgot password', size: 14),
                  ),
                ),
                SizedBox(
                  height: size.height/17,
                ),

                RoundButtonadd(
                    title: 'Sign In',
                    onpress: (){},
                    color:Colors.black26,
                    textcolor: Colors.white),

                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      ModifyText(text: 'Dont have an account ?', size: 15),
                      TextButton(onPressed: (){
                        Get.to(SignUpScreen());
                      }, child: Text('Sign Up'))
                    ],
                  ),
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
