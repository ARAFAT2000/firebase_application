import 'package:firebase_application/utils/modify_text.dart';
import 'package:firebase_application/widget/exam_re_useable.dart';
import 'package:firebase_application/widget/profile_re_useable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeBoard extends StatefulWidget {
  const NoticeBoard({super.key});

  @override
  State<NoticeBoard> createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard> {
  final DatabaseReference firestore = FirebaseDatabase.instance.ref().child('Notice');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
        title: Text('Quick Notice'),
      ),
      body:FirebaseAnimatedList(
          query: firestore.orderByKey(),
          reverse: true,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
          Animation<double> animation, int index){
            return Card(
              child: Column(
                children: [
                  Center(child:Text(snapshot.child('examtype').value.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),) ,),

                  ExamReuseable(name: 'Teacher ', value:  snapshot.child('teacher').value.toString(),),
                  ExamReuseable(name: 'Course ', value:  snapshot.child('course').value.toString(),),
                  ExamReuseable(name: 'Date ', value:  snapshot.child('date').value.toString(),),
                  ExamReuseable(name: 'Time ',
                    value:  '${snapshot.child('hour').value.toString()}:${snapshot.child('minute').value.toString()}',),

                ],
              ),
            );
          })
    );
  }
}
