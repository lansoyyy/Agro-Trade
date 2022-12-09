import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketdo/widgets/text_widget.dart';

import '../../widgets/appbar_widget.dart';
import '../../widgets/drawer_widget.dart';

class TradeRequestPage extends StatelessWidget {
  TradeRequestPage({Key? key}) : super(key: key);

  var hasRated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppbarWidget('Trade Request'),
        backgroundColor: Colors.grey[200],
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('offer')
                .where('user_id',
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return data.docs[index]['status'] == 'Pending'
                                  ? SizedBox(
                                      height: 150,
                                      child: Column(
                                        children: [
                                          ListTile(
                                            onTap: () {
                                              FirebaseFirestore.instance
                                                  .collection('products')
                                                  .doc(data.docs[index]
                                                      ['prodId'])
                                                  .delete();
                                              FirebaseFirestore.instance
                                                  .collection('offer')
                                                  .doc(data.docs[index].id)
                                                  .update({
                                                'status': 'Accepted',
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            leading: TextRegular(
                                                text: 'Accept Request',
                                                fontSize: 14,
                                                color: Colors.black),
                                            trailing: const Icon(
                                              Icons
                                                  .check_circle_outline_outlined,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          const Divider(),
                                          ListTile(
                                            onTap: () {
                                              FirebaseFirestore.instance
                                                  .collection('offer')
                                                  .doc(data.docs[index].id)
                                                  .update({
                                                'status': 'Rejected',
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            leading: TextRegular(
                                                text: 'Reject Request',
                                                fontSize: 14,
                                                color: Colors.black),
                                            trailing: const Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox(
                                      height: 150,
                                      child: Column(
                                        children: [
                                          data.docs[index]['status'] !=
                                                  'Rejected'
                                              ? ListTile(
                                                  onTap: () async {
                                                    var collection =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('users')
                                                            .where('id',
                                                                isEqualTo: data
                                                                            .docs[
                                                                        index][
                                                                    'user_id']);

                                                    var querySnapshot =
                                                        await collection.get();

                                                    for (var queryDocumentSnapshot
                                                        in querySnapshot.docs) {
                                                      Map<String, dynamic>
                                                          data1 =
                                                          queryDocumentSnapshot
                                                              .data();

                                                      FirebaseFirestore.instance
                                                          .collection('users')
                                                          .doc(data.docs[index]
                                                              ['user_id'])
                                                          .update({
                                                        'reviews':
                                                            data1['reviews'] +
                                                                1,
                                                        'ratings':
                                                            data1['ratings'] +
                                                                1,
                                                      });
                                                    }

                                                    Navigator.pop(context);
                                                  },
                                                  leading: TextRegular(
                                                      text: 'Rate Trader',
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                  trailing: const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                )
                                              : const SizedBox(),
                                          const Divider(),
                                          ListTile(
                                            onTap: () {
                                              FirebaseFirestore.instance
                                                  .collection('offer')
                                                  .doc(data.docs[index].id)
                                                  .delete();
                                              Navigator.of(context).pop();
                                            },
                                            leading: TextRegular(
                                                text: 'Delete',
                                                fontSize: 14,
                                                color: Colors.black),
                                            trailing: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                            });
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  data.docs[index]
                                                      ['myProdImage']))),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    TextBold(
                                        text: data.docs[index]['myProdName'],
                                        fontSize: 12,
                                        color: Colors.black),
                                  ],
                                ),
                                const VerticalDivider(
                                  color: Colors.grey,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextBold(
                                        text:
                                            'Trader: ${data.docs[index]['myName']}',
                                        fontSize: 12,
                                        color: Colors.black),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    TextRegular(
                                        text: data.docs[index]
                                            ['myContactNumber'],
                                        fontSize: 10,
                                        color: Colors.grey),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    TextRegular(
                                        text: data.docs[index]['myAddress'],
                                        fontSize: 10,
                                        color: Colors.grey),
                                  ],
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Divider(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextBold(
                                        text:
                                            'Trader: ${data.docs[index]['name']}',
                                        fontSize: 12,
                                        color: Colors.black),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    TextRegular(
                                        text: data.docs[index]['contactNumber'],
                                        fontSize: 10,
                                        color: Colors.grey),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    TextRegular(
                                        text: data.docs[index]['address'],
                                        fontSize: 10,
                                        color: Colors.grey),
                                  ],
                                ),
                                const VerticalDivider(
                                  color: Colors.grey,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(data
                                                  .docs[index]['imageURL']))),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    TextBold(
                                        text: data.docs[index]['prodName'],
                                        fontSize: 12,
                                        color: Colors.black),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        height: 170,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    );
                  });
            }));
  }
}
