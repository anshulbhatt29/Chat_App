import 'package:flutter/material.dart';
class SameStep extends StatelessWidget {
  final Color colour;
  final String text;
  final Function onpress;
  SameStep({this.colour,this.onpress,this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onpress,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
            style: TextStyle(color:Colors.white
            ),
          ),
          ),
          ),
        
    );
  }
}