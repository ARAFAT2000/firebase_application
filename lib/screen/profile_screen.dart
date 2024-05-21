import 'dart:io';

import 'package:firebase_application/utils/modify_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';


class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
String? imageUrl;
final ImagePicker _imagePicker = ImagePicker();


Future<void>uploadImages(File image)async{
  try{
    Reference reference = FirebaseStorage.instance.ref().child('Image/${DateTime.now().millisecondsSinceEpoch}.png');
    await reference.putFile(image).whenComplete(() {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              duration: Duration(seconds: 3),
              content: Text('Upload succesfully ')));
      
    });
    imageUrl =await reference.getDownloadURL();
  }catch(e){
    print('Fail to upload');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: ModifyText(text: 'Profile Screen', size: 20),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              children: [
                InkWell(
            onTap:()async{
              ImagePicker picker = ImagePicker();
              XFile? file = await picker.pickImage(source: ImageSource.gallery);
              print('${file!.path}');

              if(file == null) return ;
            },
                  child: CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person,size: 100,)),
                ),
                Positioned(
                  right: 15,
                    child: GestureDetector(
                      onTap: ()async{

                      },
                        child: Icon(Icons.camera_alt)))
              ],
            ),
          ),





        ],
      ),
    );
  }
}
