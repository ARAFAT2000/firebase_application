

import 'package:firebase_application/AUTH/otp_varify.dart';
import 'package:firebase_application/CRUD/Services/services_crud.dart';
import 'package:firebase_application/CRUD/all_design_decoration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//follow some process
//enable phone number
//go to project views
// set the SHA key
//RegisterPage and verification page create



class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _WriteDataScreenState();
}

class _WriteDataScreenState extends State<RegisterPage> {

  final resisterController = TextEditingController();



  FirebaseAuth _auth = FirebaseAuth.instance;

  final _key= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
          child:Container(
            margin: EdgeInsets.only(left: 15,right: 15),
            child:  Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('    Hi    \n@XYZ ',
                    style: TextStyle(
                      fontSize: 25,
                    ),),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: resisterController,
                    decoration: formDecoration('+880 ',
                        Icon(Icons.phone)
                    ),
                    validator: (name) {
                      if (name == null || name.isEmpty) {
                        return 'Enter Number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                  ),


                  SizedBox(
                    height: 35,
                  ),

                  InkWell(
                    onTap: ()async{

                      if(_key.currentState!.validate()){
                      _auth.verifyPhoneNumber(
                          timeout: const Duration(seconds: 60),
                        phoneNumber: resisterController.text.toString(),
                          verificationCompleted: (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {},
                          codeSent:  (String verificationId, int? resendToken) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>VerifyCode(varificationcode: verificationId,)));
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {}
                      );

                      }else{

                      }





                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: buttonDecoration(),
                      child: Center(
                        child: Text('Register'),),
                    ),
                  ),

                ],
              ),
            ),
          )
      ),
    );
  }

  @override
  void dispose() {
    resisterController.dispose();

    // TODO: implement dispose
    super.dispose();
  }
}