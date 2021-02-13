import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chatroom.dart';
import 'package:flutter/material.dart';
import 'samestep.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id='login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth=FirebaseAuth.instance;
  String pass,email;
  bool call=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: call,
              child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                              child: Hero(
                  tag: 'logo',
                              child: Container(
                    height: 150.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 38.0,
              ),
              TextField(
                    keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email=value;
                  //Do something with the user input.
                },
                decoration: kemail.copyWith(
                  hintText:'Enter your email'
                )
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  pass=value;
                  //Do something with the user input.
                },
                decoration: kemail.copyWith(
                  hintText:'Enter your password',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
               SameStep(colour:Colors.lightBlueAccent,onpress: ()async{ 
                 try{
                   setState(() {
                     call=true;
                   });
                  final user= await _auth.signInWithEmailAndPassword(email: email, password: pass);
                  if(user !=null)
                  {
                    
                    Navigator.pushNamed(context, Chatroom.id);

                  }

                 }
                 catch(e)
                 {
                   print('Error');
                 }
                 setState(() {
                   call=false;
                 });
               },text:'Log In'),
         
            ],
          ),
        ),
      ),
    );
  }
}
