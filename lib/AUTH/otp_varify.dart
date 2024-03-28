import 'package:firebase_application/CRUD/all_design_decoration.dart';
import 'package:firebase_application/CRUD/fetchdata_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class VerifyCode extends StatefulWidget {
  String varificationcode;
   VerifyCode({super.key,required this.varificationcode});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {

  final verifyController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 55,left:20,right: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: verifyController,
                decoration: formDecoration('0 0 0 0 0 0  ',
                    Icon(Icons.numbers)
                ),
                validator: (name) {
                  if (name == null || name.isEmpty) {
                    return 'Enter Code';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 25,
              ),

              OutlinedButton(onPressed: () async{
PhoneAuthCredential credential =PhoneAuthProvider.credential(
    verificationId: widget.varificationcode,
    smsCode: verifyController.text.toString()
);
  try{
  await _auth.signInWithCredential(credential);
  Navigator.push(context, MaterialPageRoute(builder: (context)=>FetchDataScreen()));

  }catch(e){
  print(e.toString());
 }


              }, child: Text('Verify OTP'))
            ],
          ),
        ),
      ),
    );
  }
}
