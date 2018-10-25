import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Users> zoom_users = List();

  DatabaseReference database;

  @override
  void initState() {
    super.initState();

    database = FirebaseDatabase.instance.reference().child("zoom_users");

  }


  @override
  Widget build(BuildContext context) {


   return Scaffold(
     appBar: AppBar(
       title: Text('Chat Page'),
     ),
     body: Column(
       children: <Widget>[
         new Text('Mir Mahfuz'),
         Flexible(
           child: FirebaseAnimatedList(
             query: database,
             itemBuilder: (BuildContext context, DataSnapshot snapshot,
                 Animation<double> animation, int index) {
               return new ListTile(

                 title: Text(zoom_users[index].name, style: TextStyle(color: Colors.green),),
                 subtitle: Text(zoom_users[index].phone,  style: TextStyle(color: Colors.green),),
               );
             },
           ),
         ),
       ],
     ),
   );

  }
}



class Users {
  String key;
  String name;
  String phone;
  String password;

  Users(this.name, this.phone, this.password);

  Users.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        name = snapshot.value["name"],
        phone = snapshot.value["phone"],
        password = snapshot.value["password"];

  toJson() {
    return {
      "name": name,
      "phone": phone,
      "password" : password
    };
  }
}