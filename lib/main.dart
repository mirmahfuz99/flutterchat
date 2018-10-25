import 'package:flutter/material.dart';
import 'package:flutterchat/signin.dart';
import 'package:flutterchat/signup.dart';


void main() {
  runApp(HomeScreen());
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: 'Sign Up',),
                Tab(text: 'Sign In',),
              ],
            ),
            title: Text('Chat Project'),
          ),
          body: TabBarView(
            children: [
              new SignUp(),
              new SignIn(),

            ],
          ),
        ),
      ),
    );
  }

}