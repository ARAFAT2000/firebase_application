import 'package:firebase_application/View_Model/Sign_up_controller/sign_up_controller.dart';
import 'package:firebase_application/utils/modify_text.dart';
import 'package:firebase_application/utils/textform-field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/round_botton.dart';
import '../sign_in/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController controller = Get.put(SignUpController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, right: 25, left: 25),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle
                    ),
                    child: ClipOval(
                      child: Image.asset('assets/images/group.png',
                          height: 150,
                          fit: BoxFit.fill),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 45,
                  ),
                  Card(
                    elevation: 5,
                    color: Colors.white,
                    shadowColor: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: controller.usernameController,
                        decoration: AuthPagedecoration('Username', Icon(Icons.person)),
                        validator: (value) {
                          return value!.isEmpty ? 'Enter User Name' : null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 45,
                  ),
                  Card(
                    elevation: 5,
                    color: Colors.white,
                    shadowColor: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: controller.phoneController,
                        validator: (value) {
                          return value!.isEmpty ? 'Enter Phone Number' : null;
                        },
                        decoration: AuthPagedecoration('Phone Number', Icon(Icons.call)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 45,
                  ),
                  Card(
                    elevation: 5,
                    color: Colors.white,
                    shadowColor: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: controller.emailController,
                        validator: (value) {
                          return value!.isEmpty ? 'Enter Email' : null;
                        },
                        decoration: AuthPagedecoration('Email', Icon(Icons.email_outlined)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 45,
                  ),
                  Card(
                    color: Colors.white,
                    shadowColor: Colors.blue,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: controller.passwordController,
                        validator: (value) {
                          return value!.isEmpty ? 'Enter Password' : null;
                        },
                        decoration: AuthPagedecoration('Password', Icon(Icons.password)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 17,
                  ),
                  Obx(() => RoundButton(
                    title: controller.loading.value ? 'Loading...' : 'Sign Up',
                    onpress: () {
                      if (_formKey.currentState!.validate()) {
                        controller.signUp(context,
                            controller.emailController.text,
                            controller.phoneController.text,
                            controller.passwordController.text,
                            controller.usernameController.text,);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>SignInScreen()));
                        controller.usernameController.clear();
                      controller.phoneController.clear();
                      controller.emailController.clear();
                      controller.passwordController.clear();
            
                      }
            
                    },
            
            
                  )),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        ModifyText(text: 'Already have an account ?', size: 15),
                        TextButton(
                          onPressed: () {
                            Get.to(SignInScreen());
                          },
                          child: Text('Sign In'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height / 25,
                  ),
                  ModifyText(text: 'or ', size: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/email.jpg', height: 35, width: 35),
                      Image.asset('assets/images/facebook.jpg', height: 55, width: 55),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
