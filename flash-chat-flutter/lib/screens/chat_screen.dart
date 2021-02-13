import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
  //final _textMessage=Firestore.instance;
  final _textMessage=Firestore.instance;
  FirebaseUser loggedIn;
  String name,currentuser;
  String tname;
  File pickedimage;
  String imurl;


class ChatScreen extends StatefulWidget {
    final  String na;
    final String cur;
    final String hashc;
  ChatScreen({this.na,this.cur,this.hashc});
  static const String id='chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}


class _ChatScreenState extends State<ChatScreen> {
 
 
  final messageControl=TextEditingController();
  String message='';
 final _auth=FirebaseAuth.instance;
 @override
  void initState() {
  
    super.initState();
    name=this.widget.na;
    currentuser=this.widget.cur;
    tname=this.widget.hashc;
  }


  
 /* void getUser ()async
  {
    try{
    final  nuser= await _auth.currentUser();
    if(nuser!=null){
    loggedIn=nuser;
    //name1=loggedIn.email+name;
   // name2=name+loggedIn.email;
    name1=loggedIn.email;
    name2=name;
    hash();
    }
    }
    catch(e)
    {
      print(e);
    }
  
  }*/





  Future pickImage() async{
    final picker=ImagePicker();
    final pickedImage=await picker.getImage(source: ImageSource.gallery);
      pickedimage=File(pickedImage.path);
     // upload();
     int x=pickedImage.hashCode;
  final fref=FirebaseStorage.instance.ref().child('user_image').child('$x.jpg');
   await fref.putFile(pickedimage).onComplete;
  final iurl=await fref.getDownloadURL();
  return iurl;
  //imurl=iurl;

  }
 /* void upload()async{
  final fref=FirebaseStorage.instance.ref().child('user_image').child(currentuser+'.jpg');
   await fref.putFile(pickedimage).onComplete;
  final iurl=await fref.getDownloadURL();
  imurl=iurl;
  }*/


 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
         StreamB(),
         FlatButton.icon(
           onPressed: () async
           {
            imurl=await pickImage();
                //Implement send functionality.
                    if(imurl!=null){
                      _textMessage.collection('Rooms/$tname/Messages').add({'text': null,'sender':currentuser,'url':imurl,'createdat':Timestamp.now(),
                      });
                    }
              

           },
           icon: Icon(Icons.image),
           label: Text('Add image'),
         ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageControl,

                      onChanged: (value) {

                        //Do something with the user input.
                        message=value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageControl.clear();
                      //Implement send functionality.
                      if(message!='')
                      {
                      _textMessage.collection('Rooms/$tname/Messages').add({'text': message,'sender':currentuser,'url':null,'createdat':Timestamp.now(),
                      });
                      }
                      message='';
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    }
  }

class StreamB extends StatelessWidget {
  
  @override
  Widget build(BuildContext context)  {
    
    return     StreamBuilder< QuerySnapshot>(
              stream:_textMessage.collection('Rooms/$tname/Messages').orderBy('createdat',descending: true).snapshots(),
              builder:  (context,snapshot) 
              {
                if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(backgroundColor: Colors.cyanAccent,),
                );}
                final am=snapshot.data.documents;
                List <Widget>l1=[];
                for(var sm in am)
                {
                  String mt=sm['text'];
                  final st=sm['sender'];
                  final iurl=sm['url'];
                  if(mt!=null){
                  final twidget=MessageBubble(bt: mt,bs: st,isme: currentuser==st);
                  l1.add(twidget);}
                  else{
                      final twidget=MessageBubblex(bs: st,bu:iurl,isme: currentuser==st);
                  l1.add(twidget);
                  }
                  mt=null;
                }
                return Expanded(
                                  child: ListView(
                                   reverse: true,
                                    padding: EdgeInsets.symmetric(vertical:10.0,horizontal:20.0),
                    children: l1,
                    ),
                );
              },
            );
  }
}
class MessageBubble extends StatelessWidget {
      final String bt,bs;
      final bool isme;
      
      MessageBubble({this.bt,this.bs,this.isme});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isme?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(bs,
          style: TextStyle(fontSize: 12.0,
         color: Colors.black54),),
                   Material(
          elevation: 6.0,
          borderRadius: isme ?BorderRadius.only(topLeft:Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
          bottomLeft: Radius.circular(30.0)):BorderRadius.only(topRight:Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
          bottomLeft: Radius.circular(30.0)),
    color: isme ?Colors.black54:Colors.lightBlueAccent,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:20.0,vertical:10.0),
                        child: Text(
                        bt,
                        style: TextStyle(color:isme? Colors.cyanAccent:Colors.white,
                        fontSize: 15.0),
                      ),
          ),
        ),
        ]
      ),
      );
  }
}
class MessageBubblex extends StatelessWidget {
      final String bs,bu;
      final bool isme;
      
      MessageBubblex({this.bs,this.bu,this.isme});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isme?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(bs,
          style: TextStyle(fontSize: 12.0,
         color: Colors.black54),),       
        //display
        Container(
          child:Image.network(bu),
        ),
        ]
      ),
      );
  }
}