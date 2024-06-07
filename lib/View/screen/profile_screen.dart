import 'dart:io';
import 'package:firebase_application/utils/round_botton.dart';
import 'package:firebase_application/utils/modify_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../View_Model/splass Services/sesson_services.dart';
import '../../widget/profile_re_useable.dart';
import '../auth/sign_in/sign_in_screen.dart';



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DatabaseReference usersave = FirebaseDatabase.instance.ref('User');
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    SessionController().clearUserId(); // Clear user ID from the session
    Navigator.of(context).pushReplacementNamed('/login'); // Redirect to login screen
  }

  Future<void> fetchUserData() async {
    // Fetch user-specific data here
    final userId = SessionController().userId;
    if (userId != null) {
      DatabaseEvent snapshot = await usersave.child(userId).once();
      if (snapshot.snapshot.value != null) {
        Map<dynamic, dynamic> userData = snapshot.snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          imageUrl = userData['imageUrl'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 65, left: 15, right: 15),
          child: StreamBuilder(
            stream: usersave.child(SessionController().userId.toString()).onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                final data = snapshot.data!.snapshot.value;
                if (data != null) {
                  Map<dynamic, dynamic> map = data as Map<dynamic, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              shape: BoxShape.circle,
                            ),
                            child: imageUrl == null
                                ? Icon(Icons.person, size: 50)
                                : ClipOval(
                              child: Image.network(
                                imageUrl!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height/20,
                        ),
                         GestureDetector(
                           onTap: pickImage,
                           child: Container(
                             height: size.height/20,
                             width: size.width,
        
                             decoration: BoxDecoration(
                               shape: BoxShape.rectangle,
                               border: Border.all()
                             ),
                             child: Center(
                               child: Text('Upload Picture'),
                             ),
                           ),
                         ),
                        SizedBox(
                          height: size.height/25,
                        ),
                        ModifyText(text: 'Personal Information', size: 20),

                        ProfileReuseable(
                          name: 'Name',
                          value: map['username'] ?? 'No username',
                          icon: Icons.person_outlined,
                        ),
                        ProfileReuseable(
                          name: 'Email',
                          value: map['email'] ?? 'No email',
                          icon: Icons.email,
                        ),
                        ProfileReuseable(
                          name: 'Phone',
                          value: map['phone'] ?? 'No phone number',
                          icon: Icons.call,
                        ),
                        SizedBox(
                          height: size.height/15,
                        ),
                        RoundButton(
                            title: 'Log Out',
                            onpress: (){
                              logout();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context)=>SignInScreen()),
                                    (route) => false,
                              );
                            })
        
                      ],
                    ),
                  );
                } else {
                  return Center(child: Text('No data available'));
                }
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return Center(child: Text('No data available'));
              }
            },
          ),
        ),
      ),
    );
  }

  ImagePicker _imagePicker = ImagePicker();

  Future<void> pickImage() async {
    try {
      XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        await uploadImageToFirebase(File(image.path));
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> uploadImageToFirebase(File image) async {
    try {
      final userId = SessionController().userId;
      if (userId != null) {
        Reference reference = FirebaseStorage.instance
            .ref()
            .child('UserImages/$userId/${DateTime.now().millisecondsSinceEpoch}.png');
        await reference.putFile(image).whenComplete(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully uploaded')));
        });
        String url = await reference.getDownloadURL();
        await usersave.child(userId).update({'imageUrl': url});
        setState(() {
          imageUrl = url;
        });
      }
    } catch (e) {
      print('Failed to upload image: $e');
    }
  }
}
