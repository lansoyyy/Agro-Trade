import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketdo/screens/pages/trade_request_page.dart';
import 'package:marketdo/widgets/appbar_widget.dart';
import 'package:marketdo/widgets/text_widget.dart';

class NotifPage extends StatelessWidget {
  const NotifPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('notif')
            .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .orderBy('dateTime')
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
          return Scaffold(
              backgroundColor: Colors.grey[200],
              appBar: AppbarWidget('Notifications (${data.size})'),
              body: ListView.builder(
                  itemCount: snapshot.data?.size ?? 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TradeRequestPage()));
                        },
                        tileColor: Colors.white,
                        leading: CircleAvatar(
                          minRadius: 25,
                          maxRadius: 25,
                          backgroundImage:
                              NetworkImage(data.docs[index]['profilePicture']),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextRegular(
                                text: 'New Trade Request!',
                                fontSize: 10,
                                color: Colors.grey),
                            const SizedBox(
                              height: 5,
                            ),
                            TextBold(
                                text: data.docs[index]['name'],
                                fontSize: 14,
                                color: Colors.black),
                          ],
                        ),
                        subtitle: TextRegular(
                            text: data.docs[index]['address'],
                            fontSize: 12,
                            color: Colors.grey),
                        trailing: IconButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('notif')
                                .doc(data.docs[index].id)
                                .delete();
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    );
                  }));
        });
  }
}
