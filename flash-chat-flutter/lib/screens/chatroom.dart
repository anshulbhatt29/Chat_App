import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
  FirebaseUser loggedIn;
  final _textMessage=Firestore.instance;
  String name,tname,name1,name2;

class Chatroom extends StatefulWidget {
  static const String id='chatroom';
  @override
  _ChatroomState createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
   final _auth=FirebaseAuth.instance;
   void initState() {
  
    super.initState();
    getUser();
  }
  void getUser ()async
  {
    try{
    final  nuser= await _auth.currentUser();
    if(nuser!=null)
    loggedIn=nuser;
    }
    catch(e)
    {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('baata'),
      ),  
      body: SafeArea(
      
      child: Column(
        children:[
          StreamB(),

        ]
      ),),    
    );
  }
}
class StreamB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

      return  StreamBuilder< QuerySnapshot>(
              stream:_textMessage.collection('user').snapshots(),
              builder: (context,snapshot)
              {
                final am=snapshot.data.documents.reversed;
                    List<MessageBubble> l1=[];
                for(var sm in am)
                {
                  final mt=sm['name'];
                  if( !(loggedIn.email==mt))
                  l1.add(MessageBubble(nam:mt));
                }
                 return Column(
                   children: l1,
                 );
              },
             
      );
  }
}
class MessageBubble extends StatelessWidget {
      final String nam;
      
      MessageBubble({this.nam});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: FlatButton(
          onPressed:(){
            name1=loggedIn.email;
            name2=nam;
    if(name1.hashCode<=name2.hashCode)
    {
      tname='$name1-$name2';
    }
    else{
      tname='$name2-$name1';
    }
               Navigator.push(context, MaterialPageRoute(builder:(context)=>ChatScreen(na: nam,cur:loggedIn.email,hashc:tname)));

          },
          child:Text(nam),

        ),
    );
  }
}
