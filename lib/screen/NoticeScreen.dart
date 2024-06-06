import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_application/utils/button_c.dart';
import 'package:firebase_application/utils/textform-field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Model/section_model.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({super.key});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<DropdownMenuItem<String>> teachername = [];
  List<DropdownMenuItem<String>> coursename = [];
  String tSelectedvalue = '';
  String cSelectedvalue = '';
  List<Section> section = [];
  TimeOfDay selectedTime = TimeOfDay.now();
  bool isloading = false;

  final teacherController = TextEditingController();
  final courseController = TextEditingController();
  bool isSwitch = false;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetchTeachers();
    fetchCourses();
  }

  Future<void> fetchTeachers() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('teachers').limit(10).get();
      List<DropdownMenuItem<String>> teachers = snapshot.docs.map((doc) {
        String teacherName = doc['name'];
        return DropdownMenuItem<String>(
          value: teacherName,
          child: Text(teacherName),
        );
      }).toList();
      setState(() {
        teachername = teachers;
      });
    } catch (e) {
      print('Error fetching teachers: $e');
    }
  }

  Future<void> fetchCourses() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('courses').limit(10).get();
      List<DropdownMenuItem<String>> courses = snapshot.docs.map((doc) {
        String courseName = doc['courses'];
        return DropdownMenuItem<String>(
          value: courseName,
          child: Text(courseName),
        );
      }).toList();
      setState(() {
        coursename = courses;
      });
    } catch (e) {
      print('Error fetching courses: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Switch(
            value: isSwitch,
            onChanged: (value) {
              setState(() {
                isSwitch = value;
              });
            },
          ),
          SizedBox(
            width: size.width/20,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
        child: ListView(
        //  padding: EdgeInsets.only(left: 15),
          children: [
            Card(
              elevation: 0,
              child: isSwitch
                  ? Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: teacherController,
                          decoration: AddForm('Teacher Name'),
                        ),
                      ),
                      SizedBox(width: size.width / 19),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            addNewTeacher(teacherController.text);
                          },
                          child: Container(
                            height: size.height / 12,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(),
                            ),
                            child: Center(child: Text('Save')),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height / 30),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: courseController,
                          decoration: AddForm('Course Name'),
                        ),
                      ),
                      SizedBox(width: size.width / 19),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            addNewCourse(courseController.text);
                          },
                          child: Container(
                            height: size.height / 12,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(),
                            ),
                            child: Center(child: Text('Save')),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
                  : SizedBox(),
            ),
            SizedBox(height: 40),
            Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: DropdownButtonFormField(
                      onSaved: (value) => tSelectedvalue = value ?? '',
                      validator: (value) => value == null ? "Select a teacher" : null,
                      items: teachername,
                      onChanged: (String? value) {
                        setState(() {
                          tSelectedvalue = value!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Select Teacher',
                      ),
                    ),
                  ),
                  SizedBox(width: size.width / 10),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonFormField(
                      onSaved: (value) => cSelectedvalue = value ?? '',
                      validator: (value) => value == null ? "Select a course" : null,
                      items: coursename,
                      onChanged: (String? value) {
                        setState(() {
                          cSelectedvalue = value!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Select Course',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height/12),
            Center(child: Text(' Time : ${selectedTime.hour} : ${selectedTime.minute}')),
            SizedBox(height: size.height/25),
            ElevatedButton(
              onPressed: () async {
                final TimeOfDay? timeofday = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                  initialEntryMode: TimePickerEntryMode.dial,
                );
                if (timeofday != null) {
                  setState(() {
                    selectedTime = timeofday;
                  });
                }
              },
              child: Text('Select Time'),
            ),
            SizedBox(height: size.height/25),
            RoundButton(
              loading: isloading,
              textcolor: Colors.white,
                title: 'Send Notice',
                onpress: (){
                  if(_formKey.currentState!.validate()){
                    final newSection = Section(
                      tselected: tSelectedvalue,
                      cselected: cSelectedvalue,
                      hour: selectedTime.hour,
                      minute: selectedTime.minute,
                    );
                    setState(() {
                      section.add(newSection);
                      isloading=true;
                    });
                    firestore.collection('notices').add({
                      'teacher': newSection.tselected,
                      'course': newSection.cselected,
                      'hour': newSection.hour,
                      'minute': newSection.minute,
                    });
                    setState(() {
                      isloading=false;
                    });
                    Get.snackbar('Send Notice', 'Succesfully');


                  }
                }),



          ],
        ),
      ),
    );
  }

  void addNewTeacher(String newTeacher) async {
    if (newTeacher.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('teachers').add({
          'name': newTeacher,
        });
        fetchTeachers(); // Update teacher list
        teacherController.clear();
      } catch (e) {
        print('Error adding new teacher: $e');
      }
    }
  }

  void addNewCourse(String newCourse) async {
    if (newCourse.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('courses').add({
          'courses': newCourse,
        });
        fetchCourses(); // Update course list
        courseController.clear();
      } catch (e) {
        print('Error adding new course: $e');
      }
    }
  }
}
