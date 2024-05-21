import 'package:firebase_application/utils/button.dart';
import 'package:firebase_application/utils/modify_text.dart';
import 'package:firebase_application/utils/textform-field.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

final titleController= TextEditingController();
final desController= TextEditingController();




DatabaseReference ref = FirebaseDatabase.instance.ref().child('AddData');

 final _key= GlobalKey<FormState>();
 bool loading=false;
  @override
  Widget build(BuildContext context) {
    final size= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: ModifyText(text: 'Add Your Thoughts', size: 20),
        backgroundColor: Colors.black12,
      ),

      body: Column(
        children: [
          SizedBox(
            height: size.height/15,
          ),
        Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: titleController,
                        keyboardType: TextInputType.text,
                        decoration: TextFieldDesign('Title'),
                        validator: (value){
                          return value!.isEmpty ? 'Enter Title': null;
                        },
                      ),

                     SizedBox(
                       height: 20,
                     ),
                      TextFormField(
                        controller: desController,
                        maxLines: 4,
                        keyboardType: TextInputType.text,
                        decoration: TextFieldDesign('Details'),
                        validator: (value){
                          return value!.isEmpty ? 'Enter Description': null;
                        },
                      ),


                      SizedBox(
                        height: 20,
                      ),

                      RoundButtonadd(
                        loading: false,
                          title: 'Submit',
                          onpress: (){
                            if(_key.currentState!.validate() ){
                              setState(() {
                                loading=true;
                              });
                          String id= DateTime.now().millisecondsSinceEpoch.toString();
                             Map<String,dynamic> AddData={
                               'title' : titleController.text.toString(),
                               'description' : desController.text.toString(),
                               'id':id
                             };
                             ref.child(id).set(AddData);
                              setState(() {
                                loading=false;
                              });
                          Get.snackbar('', 'Succesfully add ');
                              titleController.clear();
                              desController.clear();

                            }


                          },
                          color: Colors.black54,
                          textcolor: Colors.white)

                    ],
                  ),
                ),
              ),
            ))
        ],
      ),
    );
  }




  @override
  void dispose() {
    titleController.dispose();
    desController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}


