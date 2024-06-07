import 'package:firebase_application/View_Model/Sign_in_controller/sign_in_controller.dart';
import 'package:firebase_application/utils/modify_text.dart';
import 'package:firebase_application/utils/textform-field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../View/dashboard/dasboard.dart';
import '../../../utils/round_botton.dart';
import '../sign_up/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  SignInController controller = Get.put(SignInController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
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
                        controller: controller.emailController,
                        validator: (value) {
                          return value!.isEmpty ? 'Enter Email' : null;
                        },
                        decoration: AuthPagedecoration('email', Icon(Icons.email_outlined)),
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
                        decoration: AuthPagedecoration('password', Icon(Icons.password)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 75,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ModifyText(text: 'forgot password', size: 14),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 17,
                  ),
                  Obx(() => RoundButton(
                    title: controller.loading.value ? 'Loading...' : 'Sign In',
                    onpress: () {
                      if (_formKey.currentState!.validate()) {
                        controller.loginUser(
                            controller.emailController.text,
                            controller.passwordController.text
                        );
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context)=>BottomNavbar()),
                            (route) => false,
                      );
                      }
                    },

                  )),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        ModifyText(text: 'Don\'t have an account?', size: 15),
                        TextButton(
                          onPressed: () {
                            Get.to(() => SignUpScreen());
                          },
                          child: Text('Sign Up'),
                        ),
                      ],
                    ),
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
