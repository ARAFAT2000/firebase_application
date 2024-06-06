import 'dart:io';

import 'package:firebase_application/utils/modify_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';


import '../widget/re_useable.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String ? imageurl;
  ImagePicker _imagePicker= ImagePicker();
  @override
  Widget build(BuildContext context) {
    final size= MediaQuery.of(context).size;
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.only(top: 65,left: 15,right: 15),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(

                radius: 60,
                child:imageurl == null
                    ? Icon(Icons.person,size: 100,)
                    :ClipOval(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.network(
                      height: size.height/6,
                      width: size.width/2,
                      fit: BoxFit.cover,
                      imageurl!),
                    )),),

            SizedBox(
              height: size.height/25,
            ),
            Row(

              children: [
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: pickImage,
                    child: Container(
                      height: size.height/16,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Text('Upload Profile Picture',
                          style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.bold,
                            fontSize: 15
                          ),),),
                    ),
                  ),
                ),

              ],
            ),

            SizedBox(
              height: size.height/25,
            ),
            ModifyText(text: 'Personal Information', size: 20),
            SizedBox(
              height: size.height/35,
            ),
            Card(
                child: SizedBox(
                  height: size.height/4,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10,top: 25),
                    child: Column(
                      children: [
                        Reuseable(name: 'Name', value: 'Arafat',),
                        Divider(),
                        Reuseable(name: 'Name', value: 'Arafat',),
                        Divider(),
                        Reuseable(name: 'Name', value: 'Arafat',),
                        Divider(),
                        Reuseable(name: 'Name', value: 'Arafat',),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
  Future<void> pickImage() async {

    try{
      XFile ? images = await _imagePicker.pickImage(source: ImageSource.gallery);
      if(images != null){
        await uploadImagetoFirebase(File(images.path));
      }

    }catch(e){
      print('Error');
    }
  }

  Future<void>uploadImagetoFirebase(File images)async{

    try{

      Reference reference= FirebaseStorage.instance.ref().child('Image/${DateTime.now().millisecondsSinceEpoch}.png');
      await reference.putFile(images).whenComplete(() {
        ScaffoldMessenger.of(context).
        showSnackBar(SnackBar(content: Text('Succesfullly upload')));
      });

      String  url= await reference.getDownloadURL();

      setState(() {
        imageurl = url;
      });

    }catch(e){
      print('failed');
    }
  }

}


