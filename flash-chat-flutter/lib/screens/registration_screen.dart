import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'samestep.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chatroom.dart';
final auth1=Firestore.instance;


class RegistrationScreen extends StatefulWidget {
  static const String id='registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _auth=FirebaseAuth.instance;
  String email,pass;
  bool call=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: call,
              child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
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
                decoration:kemail.copyWith(
                  hintText:'Enter your email',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  pass=value;
                  //Do something with the user input.
                },
                decoration:kemail.copyWith(
                  hintText:'Enter your password',
                )
              ),
              SizedBox(
                height: 24.0,
              ),
               SameStep(colour:Colors.blueAccent,onpress: ()async{ 
                 setState(() {
                   call=true;
                 });
                 try{
                   final newUser=await _auth.createUserWithEmailAndPassword(email: email, password: pass);
                   if(newUser!=null)
                   {
                       auth1.collection('user').add({
                     'name':newUser.user.email,
                    });
                    
                     
                    Navigator.pushNamed(context, Chatroom.id);

                   }

                 }
                 catch(e)
                 {
                   print(e);
                 }
                 setState(() {
                   call=false;
                 });
                
               },text:'Register'),
            
            ],
          ),
        ),
      ),
    );
  }
}
