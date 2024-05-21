
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
DatabaseReference ref= FirebaseDatabase.instance.ref().child('AddData');
final titleedit= TextEditingController();
final descedit= TextEditingController();

Future<void>updateData(context,String title,String description,String id){
  titleedit.text=title;
  descedit.text=description;


  return showDialog(context: context,
      builder: (context){
        return AlertDialog(

          title: Text('Update'),
          content: Container(
            constraints: BoxConstraints(
              maxHeight: 250, // Set a maximum height for the dialog
            ),
            child: Column(
              children: [
                TextField(
                  controller: titleedit,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  maxLines: 4,
                  controller: descedit,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('Cancel')),
            TextButton(onPressed: (){
              ref.child(id).update({
                'title':titleedit.text.toString(),
                'description':descedit.text.toString(),
              });
              Navigator.pop(context);
            }, child: Text('Save')),
          ],
        );
      });

}