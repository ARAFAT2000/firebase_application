import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_application/CRUD/Services/services_crud.dart';
import 'package:firebase_application/CRUD/all_design_decoration.dart';
import 'package:firebase_application/CRUD/fetchdata_screen.dart';
import 'package:flutter/material.dart';

class WriteDataScreen extends StatefulWidget {
  const WriteDataScreen({super.key});

  @override
  State<WriteDataScreen> createState() => _WriteDataScreenState();
}

class _WriteDataScreenState extends State<WriteDataScreen> {

  final subjectController = TextEditingController();
  final descController = TextEditingController();

  CrudServices crudServices= CrudServices();

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
                  controller: subjectController,
                    decoration: formDecoration('Subject',
                        Icon(Icons.subject)
                    ),
                  validator: (name) {
                    if (name == null || name.isEmpty) {
                      return 'Enter Subject';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                    controller: descController,
                    decoration: formDecoration('Description',
                        Icon(Icons.description)),
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return ' Enter Description';
                    }
                    return null;
                  },
                  maxLines: 4,
                ),

                SizedBox(
                  height: 35,
                ),

                InkWell(
                  onTap: (){

                    if(_key.currentState!.validate()){

                      crudServices.addData.doc().set({
                        'name':subjectController.text,
                        'email':descController.text,

                      }).then((value) {

                      }).onError((error, stackTrace) {
                        print(error.toString());
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FetchDataScreen()));
                    }else{

                    }

                    subjectController.clear();
                    descController.clear();

                    print('Add data');
                  },
                  child: Container(
                    width: double.infinity,
                      height: 50,
                      decoration: buttonDecoration(),
                      child: Center(
                        child: Text('Save'),),
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
    subjectController.dispose();
    descController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
