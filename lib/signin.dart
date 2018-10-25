import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class SignIn extends StatefulWidget {


  @override
  _SignInState createState() => new _SignInState();
}
class _SignInState extends State<SignIn> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passsController = new TextEditingController();
  DatabaseReference database;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    database = FirebaseDatabase.instance.reference().child("Zoom_users");
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: new ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: <Widget>[

          new TextFormField(
            decoration: const InputDecoration(
                icon: const Icon(Icons.phone),
                hintText: 'Enter a phon number',
                labelText: 'Phone'
            ),
            controller: emailController,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
            ],
          ),
          new TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.email),
              hintText: 'Enter Password',
              labelText: 'Password',
            ),
            controller: passsController,

          ),

          new RaisedButton(

              onPressed: (){
                if(emailController.text.isNotEmpty && passsController.text.isNotEmpty) {
                  var user_info = <String, dynamic>{
                    'phone': emailController.text,
                    'password': passsController.text,
                  };

                  database.push().set(user_info);
                }


              })



        ],
      ),
    );
  }
}