import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageTextField extends StatefulWidget {
  //const MessageTextField({Key? key}) : super(key: key);
  final String? currentId;
  final String friendID;

  MessageTextField(
      this.currentId,
      this.friendID
  );


  @override
  _MessageTextFieldState createState() => _MessageTextFieldState();

}

class _MessageTextFieldState extends State<MessageTextField> {
  TextEditingController _controller = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.white,
      padding: EdgeInsetsDirectional.all(8),
      child: Row(
        children: [
          Expanded(child: TextField (
            controller: _controller,
            decoration: InputDecoration(
              labelText: "Type your Message",
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 0),
                gapPadding: 10,
                borderRadius: BorderRadius.circular(25)
              )
            ),
      )),

          SizedBox(width: 20,),
          GestureDetector(
            onTap: ()async{
              String message = _controller.text;
              _controller.clear();
              await FirebaseFirestore.instance.collection('seller').doc(user!.uid).collection('messages').doc(widget.friendID).collection('chats').add({
                'senderId':user!.uid,
                "receiverId": widget.friendID,
                "message":message,
                "type":"text",
                "date":DateTime.now(),
              }).then((value) {
                FirebaseFirestore.instance.collection('seller').doc(user!.uid).collection('messages').doc(widget.friendID).set({
                  "last_msg": message,
                });
              });

              await FirebaseFirestore.instance.collection('seller').doc(widget.friendID).collection('messages').doc(user!.uid).collection("chats").add({
                'senderId':user!.uid,
                "receiverId": widget.friendID,
                "message":message,
                "type":"text",
                "date":DateTime.now(),
              }).then((value) {
                FirebaseFirestore.instance.collection('seller').doc(widget.friendID).collection('messages').doc(user!.uid).set({
                  "last_msg": message,
                });
              });
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.shade900,
              ),
              child: Icon(Icons.send, color: Colors.white,),
            ),
          )
        ],
      ),
    );
  }

}