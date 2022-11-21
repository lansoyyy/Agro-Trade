import 'package:agro_trading/models/exchange_model.dart';
import 'package:agro_trading/screens/chat/single_message.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/seller_model.dart';
import '../../models/user_model.dart';
import 'message_textfeild.dart';

class ChatScreen extends StatelessWidget {
  static const String id = 'chatscreen';
  //const ChatScreen({ Key? key}) : super(key: key);
  final SellerModel currentUser;
  final String friendID;
  final String friendName;

  const ChatScreen({
    required this.currentUser,
    required this.friendID,
    required this.friendName,
  });

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    ExchangeModel exchangeModel = ExchangeModel();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: const Icon(Icons.account_circle)),
            const SizedBox(
              width: 5,
            ),
            Text(
              friendName,
              style: const TextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 90),
              child: Container(
                child: ElevatedButton(
                    onPressed: () {
                      showAlertDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                        shadowColor: Colors.blue.shade800),
                    child: const Text('Deal')),
              ),
            ),
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          SellerModel sellermodel = SellerModel();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen(sellermodel)));
        },
      ),*/
      body: Column(
        children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("seller")
                    .doc(user!.uid)
                    .collection('messages')
                    .doc(friendID)
                    .collection('chats')
                    .orderBy("date", descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.docs.length < 1) {
                      return const Center(
                        child: Text("Say Hi"),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        reverse: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          bool isMe =
                              snapshot.data.docs[index]['senderId'] == user.uid;
                          return SingleMessage(
                              message: snapshot.data.docs[index]['message'],
                              isMe: isMe);
                        });
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          )),
          MessageTextField(currentUser.sellerId, friendID),
        ],
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
  Widget onPositiveButton = TextButton(
      onPressed: () {
        final snackBar = const SnackBar(content: Text('Trade Complete!'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pop(context);
      },
      child: const Text('OK'));
  Widget onNegativeButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
//delete product
      },
      child: const Text('CANCEL'));
  AlertDialog dialog = AlertDialog(
    actions: [onNegativeButton, onPositiveButton],
    title: const Text('Deal or No Deal'),
    content: const Text('Do you want to close the deal?'),
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      });
}
