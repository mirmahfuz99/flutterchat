import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignIn extends StatefulWidget {


  @override
  _SignInState createState() => new _SignInState();
}
class _SignInState extends State<SignIn> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
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

          ),


          new Container(
            padding: const EdgeInsets.only(left: 40.0, top: 40.0),
            child: new RaisedButton(onPressed: null, child: new Text('Submit'),),
          )
        ],
      ),
    );
  }
}