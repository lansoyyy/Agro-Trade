import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketdo/screens/tabs/convo_page.dart';
import 'package:marketdo/widgets/text_widget.dart';

class MessageTab extends StatelessWidget {
  MessageTab({Key? key}) : super(key: key);

  final box = GetStorage();

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
                    leading: CircleAvatar(
                      minRadius: 25,
                      maxRadius: 25,
                      backgroundImage: NetworkImage(
                          data.docs[index]['profilePicOfPersonToSend']),
                    ),
                    onTap: () {
                      box.write('uid', data.docs[index].id);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ConvoPage()));
                    },
                    title: Text(
                      data.docs[index]['message'],
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'QBold'),
                    ),
                    subtitle: TextRegular(
                        text: data.docs[index]['nameOfPersonToSend'] +
                            ' - ' +
                            data.docs[index]['time'],
                        fontSize: 10,
                        color: Colors.grey),
                    tileColor: Colors.white,
                    trailing: IconButton(
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection(FirebaseAuth.instance.currentUser!.uid)
                            .doc(data.docs[index].id)
                            .delete();
                      },
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ),
                );
              }));
        });
  }
}
