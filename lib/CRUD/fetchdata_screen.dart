import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_application/CRUD/Services/services_crud.dart';
import 'package:firebase_application/CRUD/write_data_screen.dart';
import 'package:flutter/material.dart';

class FetchDataScreen extends StatefulWidget {
  const FetchDataScreen({super.key});

  @override
  State<FetchDataScreen> createState() => _FetchDataScreenState();
}

class _FetchDataScreenState extends State<FetchDataScreen> {

  CrudServices crudServices= CrudServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        centerTitle: true,
        title: Text('Fetch Data Screen'),
      ),
      floatingActionButton: FloatingActionButton.extended(

          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>WriteDataScreen()));
          },
          label: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 30,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Icon(Icons.add))),
              SizedBox(
                width: 5,
              ),
              Text('Add Data'),
            ],
          )),
      body:StreamBuilder(
          stream: crudServices.showData,
          builder: ( context ,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>snapshot){
            List addnotelist = snapshot.data!.docs;

            if (snapshot.connectionState == ConnectionState.waiting) {

              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {

              return Center(child: CircularProgressIndicator());
            }
            else if (snapshot.data == null) {

              return Center(child: CircularProgressIndicator());
            }
            else if(snapshot.hasData && snapshot.data != null){

              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: addnotelist.length,

                  itemBuilder: (context,index){

                    var getdata= snapshot.data!.docs[index];

                    return ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.update),
                      ),
                      title: Text(getdata['name'].toString(),
                        style: TextStyle(
                          fontSize: 18
                        ),),
                      subtitle: Text(getdata['email'].toString()),
                      trailing:InkWell(
                          onTap: (){
                            print('Delete');
                      crudServices.deleteNote(getdata.id.toString());
                          },
                          child: Icon(Icons.delete)),
                    );
                  });
            }
            return Center(
              child: CircularProgressIndicator(),);
          }
      )
    );
  }
}
