import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => new _SignUpState();
}
class _SignUpState extends State<SignUp> {
  List<User> users = List();
  User user;
  DatabaseReference userRef;

  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();





  @override
  void initState() {
    super.initState();
    user = User("", "" , "");
    final FirebaseDatabase database = FirebaseDatabase.instance; //Rather then just writing FirebaseDatabase(), get the instance.
    userRef = database.reference().child('users');
    userRef.onChildAdded.listen(_onEntryAdded);
    userRef.onChildChanged.listen(_onEntryChanged);
  }


  _onEntryAdded(Event event){
    setState(() {
      users.add(User.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event) {
    var old = users.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      users[users.indexOf(old)] = User.fromSnapshot(event.snapshot);
    });
  }

  void handleSubmit(){
    final FormState form = formKey.currentState;

    if(form.validate()){
      form.save();
      form.reset();
      userRef.push().set(user.toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: Form(
        key: formKey,
        child: new ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            new TextFormField(

              decoration: const InputDecoration(
                icon: const Icon(Icons.person),
                hintText: 'Enter your name',
                labelText: 'Name',
              ),
              initialValue: "",
              onSaved: (val) => user.name = val,
              validator: (val) => val == "" ? val : null,
            ),

            new TextFormField(
              decoration: const InputDecoration(
                  icon: const Icon(Icons.phone),
                  hintText: 'Enter a phon number',
                  labelText: 'Phone'
              ),
              initialValue: "",
              onSaved: (val) => user.phone = val,
              validator: (val) => val == "" ? val : null,
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
              initialValue: "",
              onSaved: (val) => user.password = val,
              validator: (val) => val == "" ? val : null,

            ),


            new Container(
              padding: const EdgeInsets.only(left: 40.0, top: 40.0),
              child: new RaisedButton(onPressed: handleSubmit, child: new Text('Submit'),),
            )
          ],
        ),
      ),
    );
  }
}



class User {
  String key;
  String name;
  String password;
  String phone;

  User(this.name, this.phone, this.password);


  User.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        name = snapshot.value["name"],
        phone = snapshot.value["phone"],
        password = snapshot.value["password"];


  toJson() {
    return {
      "name": name,
      "password": password,
      "phone": phone,
    };
  }
}










