import 'package:flutter/material.dart';
import 'samestep.dart';

import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id='welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>  with SingleTickerProviderStateMixin {
  AnimationController ac;
  Animation a;
  int i=0;
  @override
  void initState() {
    super.initState();
    ac=AnimationController(duration: Duration(seconds: 2),
    vsync:this,);
    a=CurvedAnimation(parent:ac,curve:Curves.easeIn);
    ac.forward();
    a.addStatusListener((status) 
      {
      if(status==AnimationStatus.completed)
      {
        
        ac.reverse(from:1);
      }
      else if(status==AnimationStatus.dismissed)
      {
        
        ac.forward();
      }
  
    });
    ac.addListener(() {
      setState(() { 
      });
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: a.value *50,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text:['Flash Chat'],
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            SameStep(colour:Colors.lightBlueAccent,onpress: (){ Navigator.pushNamed(context, LoginScreen.id);},text:'Log In'),
            SameStep(colour: Colors.blueAccent,onpress: (){  Navigator.pushNamed(context, RegistrationScreen.id);},text:'Register'),
          ],
        ),
      ),
    );
  }
}


