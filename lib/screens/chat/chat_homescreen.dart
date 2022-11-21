import 'package:agro_trading/screens/chat/chat_screen.dart';
import 'package:agro_trading/screens/chat/search_screen.dart';
import 'package:agro_trading/widgets/custom_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../models/seller_model.dart';
import '../../widgets/navbar.dart';

class ChatHomeScreen extends StatefulWidget {
  static const String routeName = '/chathomescreen';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => ChatHomeScreen());
  }

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  @override
  Widget build(BuildContext context) {
    SellerModel user = SellerModel();
    User? seller = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Chat Screen',
      ),
      bottomNavigationBar: const NavBar(),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('seller')
              .doc(seller!.uid)
              .collection('messages')
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.length < 1) {
                return const Center(
                  child: Text("No Chats Available !"),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    var friendID = snapshot.data.docs[index].id;
                    var lastMsg = snapshot.data.docs[index]['last_msg'];
                    return FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('seller')
                          .doc(friendID)
                          .get(),
                      builder: (context, AsyncSnapshot asyncSnapshot) {
                        if (asyncSnapshot.hasData) {
                          var friend = asyncSnapshot.data;
                          return ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(80),
                              child: const Icon(Icons.account_circle),
                            ),
                            title: Text(friend['sellerName']),
                            subtitle: Container(
                              child: Text(
                                '$lastMsg',
                                style: const TextStyle(color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                            currentUser: user,
                                            friendID: friend['sellerId'],
                                            friendName: friend['sellerName'],
                                          )));
                            },
                          );
                        }
                        return const LinearProgressIndicator();
                      },
                    );
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: () {
          SellerModel sellerModel = SellerModel();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchScreen(sellerModel)));
        },
      ),
    );
  }
}
