import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
class CrudServices{

 //when data add
 final addData = FirebaseFirestore.instance.collection('AddData');

 //when data show
 final  showData = FirebaseFirestore.instance.collection('AddData').snapshots();

 //update data
 final updateData = FirebaseFirestore.instance.collection('AddData');


 //delete data
 Future<void> deleteNote(String Docid) {
  return addData.doc(Docid).delete();
 }

}


