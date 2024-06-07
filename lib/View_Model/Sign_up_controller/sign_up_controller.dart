import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../splass Services/sesson_services.dart';

class SignUpController extends GetxController {
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final loading = false.obs;

  FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference usersave = FirebaseDatabase.instance.ref().child('User');

  void signUp(BuildContext context,String email,String phone, String password, String username) async {
   try{

     UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: email,
       password: password,
     );

     String uid = userCredential.user!.uid;

     await FirebaseDatabase.instance.ref('User').child(uid).set({
       'username': username,
       'email': email,
       'phone': phone,
       // Other user details
     });

     SessionController().setUserId(uid);

   }catch(e){
     print(e.toString());
   }


  }




  @override
  void dispose() {
    usernameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
