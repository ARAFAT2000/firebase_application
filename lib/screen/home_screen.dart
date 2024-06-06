
import 'package:firebase_application/utils/modify_text.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';


import '../widget/update_data.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DatabaseReference ref= FirebaseDatabase.instance.ref().child('AddData');
  final searchController= TextEditingController();

  final titleedit= TextEditingController();
  final descedit= TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size= MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(

        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 45,right: 10),
          child: TextFormField(
            controller: searchController,
            decoration: InputDecoration(
                hintText: 'Search here',
              suffixIcon: Icon(Icons.clear)
            ),
            onChanged: (String  value){
              setState(() {

              });
            },
          ),
        ),

      ),

      body:Padding(
        padding: const EdgeInsets.only(left: 10,right: 10,top: 45),
        child: FirebaseAnimatedList(
          query: ref.orderByKey(),
          reverse: true,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            final  title=snapshot.child('title').value.toString().toLowerCase();
            final imageUrl = snapshot.child('image_url').value?.toString() ?? '';
            if(searchController.text.isEmpty){
              return Card(
                elevation: 1,
                color: Colors.black12,
                child: Column(
                  children: [
                    imageUrl.isEmpty
                        ? Text(' No Image')
                        : Image.network(
                      imageUrl,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    ListTile(
                        leading: CircleAvatar(child: Text('${index + 1}')),
                        title: ModifyText(text: snapshot.child('title').value.toString(), size: 20,),
                        subtitle: ModifyText(text: snapshot.child('description').value.toString(), size: 15) // Assuming 'AddData' is a direct child of your database reference
                         ,
                      trailing:PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                          itemBuilder: (context)=>[
                            PopupMenuItem(
                              value: 1,
                                //snapshot.child('title').value.toString(),
                                child: ListTile(
                                  onTap: (){
                                    Navigator.pop(context);
                                   updateData(context,
                                       snapshot.child('title').value.toString(),
                                       snapshot.child('description').value.toString(),
                                       snapshot.child('id').value.toString()
                                   );

                                  },

                                  leading: Icon(Icons.edit),

                                  title: Text('Edit'),
                                )),
                            PopupMenuItem(
                                value: 2,
                                child: ListTile(
                                  onTap: (){
                                    Navigator.pop(context);
                                    ref.child(snapshot.child('id').value.toString()).remove();
                                  },
                                  leading: Icon(Icons.delete),
                                  title: Text('Delete'),
                                )),
                          ]) ,
                    ),
                  ],
                ),
              );
            }else if(title.toLowerCase().contains(searchController.text.toLowerCase().toString())){
              return InkWell(
                onTap: (){

                },
                child: Card(
                  elevation: 1,
                  color: Colors.lime,
                  child: ListTile(
                      title: ModifyText(text: snapshot.child('title').value.toString(),
                        size: 20, ),
                      subtitle: ModifyText(
                        text: snapshot.child('description').value.toString(), size: 15,) // Assuming 'AddData' is a direct child of your database reference
                  ),
                ),
              );
            }else{
              return Container();
            }

          },
        ),
      ),
    );
  }



}

