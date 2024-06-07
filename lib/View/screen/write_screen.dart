
import 'package:firebase_application/utils/modify_text.dart';
import 'package:firebase_application/utils/textform-field.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../utils/round_botton.dart';



class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  final titleController = TextEditingController();
  final desController = TextEditingController();

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('AddData');
  final _key = GlobalKey<FormState>();
  bool loading = false;
  String? imageUrl;

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickImage() async {
    try {
      XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        File imageFile = File(image.path);
        await uploadImage(imageFile);
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> uploadImage(File imageFile) async {
    try {
      setState(() {
        loading = true;
      });

      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference = FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;

      String downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        imageUrl = downloadUrl;
        loading = false;
      });

      print('Image uploaded: $downloadUrl');
    } catch (e) {
      print('Error uploading image: $e');
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: ModifyText(text: 'Create Class Notice', size: 20),
        backgroundColor: Colors.black12,
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height / 15,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: titleController,
                        keyboardType: TextInputType.text,
                        decoration: TextFieldDesign('Title'),
                        validator: (value) {
                          return value!.isEmpty ? 'Enter Title' : null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: desController,
                        maxLines: 3,
                        keyboardType: TextInputType.text,
                        decoration: TextFieldDesign('Details'),
                        validator: (value) {
                          return value!.isEmpty ? 'Enter Description' : null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: imageUrl == null
                            ? Icon(Icons.person, size: 150)
                            : Image.network(imageUrl!,height: 150,width: 150,),
                      ),
                      TextButton(
                        onPressed: () {
                          pickImage();
                        },
                        child: Text('Select Image'),
                      ),

                      RoundButton(
                        loading: loading,
                        title: 'Submit',
                        onpress: () {
                          if (_key.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });

                            String id = DateTime.now().millisecondsSinceEpoch.toString();
                            Map<String, dynamic> addData = {
                              'title': titleController.text.toString(),
                              'description': desController.text.toString(),
                              'image_url': imageUrl,
                              'id': id
                            };

                            ref.child(id).set(addData).then((_) {
                              setState(() {
                                loading = false;
                              });
                              Get.snackbar('Success', 'Successfully added');
                              titleController.clear();
                              desController.clear();
                              setState(() {
                                imageUrl = null;
                              });
                            }).catchError((error) {
                              setState(() {
                                loading = false;
                              });
                              Get.snackbar('Error', 'Failed to add: $error');
                            });
                          }
                        },


                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    desController.dispose();
    super.dispose();
  }
}
