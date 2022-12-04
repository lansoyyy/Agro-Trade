import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketdo/widgets/text_widget.dart';

class MessageTab extends StatelessWidget {
  const MessageTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('error');
            return const Center(child: Text('Error'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('waiting');
            return const Padding(
              padding: EdgeInsets.only(top: 50),
              child: Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              )),
            );
          }

          final data = snapshot.requireData;
          return ListView.builder(
              itemCount: snapshot.data?.size ?? 0,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: ListTile(
                    leading: const CircleAvatar(
                      minRadius: 25,
                      maxRadius: 25,
                      backgroundImage: AssetImage('assets/images/profile.png'),
                    ),
                    title: TextBold(
                        text: 'Lance Olana', fontSize: 14, color: Colors.black),
                    subtitle: TextRegular(
                        text: '08:45pm', fontSize: 10, color: Colors.grey),
                    tileColor: Colors.white,
                    trailing: IconButton(
                      onPressed: () {
                        //  FirebaseFirestore.instance
                        //                               .collection('offer')
                        //                               .doc(data.docs[index].id)
                        //                               .delete();
                      },
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ),
                );
              }));
        });
  }
}
