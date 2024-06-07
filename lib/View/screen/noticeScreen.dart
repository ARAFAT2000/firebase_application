import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:firebase_application/utils/round_botton.dart';
import 'package:firebase_application/utils/textform-field.dart';

import '../../Model/section_model.dart';

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
  String examtypeselected = '';
  List<Section> section = [];

  bool isloading = false;

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  final teacherController = TextEditingController();
  final courseController = TextEditingController();
  bool isSwitch = false;
  final DatabaseReference firestore = FirebaseDatabase.instance.ref().child('Notice');

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

  String formatDateTime(DateTime date) {
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
    return dateFormatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Switch(

            activeColor: Colors.green[600],
            inactiveThumbColor: Colors.white,
            value: isSwitch,
            onChanged: (value) {
              setState(() {
                isSwitch = value;
              });
            },
          ),
          SizedBox(
            width: size.width / 20,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
        child: ListView(
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
                      validator: (value) =>
                      value == null ? "Select a teacher" : null,
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
                      validator: (value) =>
                      value == null ? "Select a course" : null,
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
            DropdownButtonFormField<String>(
              items: [
                DropdownMenuItem(
                  value: 'Class Test',
                  child: Text('Class Test'),
                ),
                DropdownMenuItem(
                  value: 'Mid',
                  child: Text('Mid'),
                ),
              ],
              onSaved: (value) => examtypeselected = value ?? '',
              validator: (value) => value == null ? "Select Exam Type" : null,
              onChanged: (value) {
                setState(() {
                  examtypeselected = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Select Exam Type',
              ),
            ),

            SizedBox(height: size.height / 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    selectedTime != null
                        ? ' Time: ${selectedTime!.hour} : ${selectedTime!.minute}'
                        : 'No time selected',
                  ),
                ),
                Expanded(
                  child: Text(
                    selectedDate != null
                        ? 'Date: ${formatDateTime(selectedDate!)}'
                        : 'No Date selected',
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height / 25),
            ElevatedButton(
              onPressed: () async {
                final DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: selectedDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );

                if (date != null) {
                  final TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: selectedTime ?? TimeOfDay.now(),
                    initialEntryMode: TimePickerEntryMode.dial,
                  );

                  if (time != null) {
                    setState(() {
                      selectedDate = date;
                      selectedTime = time;
                    });
                  }
                }
              },
              child: Text('Select Date and Time'),
            ),
            SizedBox(height: size.height / 25),
            RoundButton(
              loading: isloading,
              textcolor: Colors.white,
              title: 'Send Notice',
              onpress: () {
                if (_formKey.currentState!.validate()) {
                  final newSection = Section(
                    tselected: tSelectedvalue,
                    examtype: examtypeselected,
                    cselected: cSelectedvalue,
                    hour: selectedTime!.hour,
                    minute: selectedTime!.minute,
                    date: selectedDate!,
                  );
                  setState(() {
                    section.add(newSection);
                    isloading = true;
                  });
                  String id = DateTime.now().millisecondsSinceEpoch.toString();
                  Map<String,dynamic> noticeInformation={
                    'teacher': newSection.tselected,
                    'course': newSection.cselected,
                    'hour': newSection.hour,
                    'minute': newSection.minute,
                    'date': newSection.date.toIso8601String(),
                    'examtype':newSection.examtype,
                    'id':id
                  };
                  firestore.child(id).set(noticeInformation)
                 .then((_) {
                    setState(() {
                      isloading = false;
                    });
                    Get.snackbar('Send Notice', 'Successfully sent notice');
                  }).catchError((error) {
                    setState(() {
                      isloading = false;
                    });
                    Get.snackbar('Error', 'Failed to send notice: $error');
                  });
                }
              },
            ),
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
