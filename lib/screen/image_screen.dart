

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// it is correct  now
class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {

  String ? imageurl;

  ImagePicker _imagePicker= ImagePicker();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload'),
      ),
      body: Center(
        child: imageurl==null ? Icon(Icons.person,size: 150,):Image.network(imageurl!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add),
      ),
    );
  }
}