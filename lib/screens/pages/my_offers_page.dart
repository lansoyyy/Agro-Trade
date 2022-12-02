import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketdo/widgets/appbar_widget.dart';
import 'package:marketdo/widgets/text_widget.dart';

import '../../widgets/drawer_widget.dart';

class MyOffersPage extends StatelessWidget {
  const MyOffersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('My Offers'),
      backgroundColor: Colors.grey[200],
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('offer')
              .where('my_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: GestureDetector(
                      onDoubleTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text(
                                    'Delete Confirmation',
                                    style: TextStyle(
                                        fontFamily: 'QBold',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: const Text(
                                    'Are you sure you want to delete this transaction?',
                                    style: TextStyle(fontFamily: 'QRegular'),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: const Text(
                                        'Close',
                                        style: TextStyle(
                                            fontFamily: 'QRegular',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    FlatButton(
                                      onPressed: () async {
                                        FirebaseFirestore.instance
                                            .collection('offer')
                                            .doc(data.docs[index].id)
                                            .delete();
                                        Navigator.of(context).pop(true);
                                      },
                                      child: const Text(
                                        'Continue',
                                        style: TextStyle(
                                            fontFamily: 'QRegular',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ));
                      },
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: SizedBox(
                                  height: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  data.docs[index]['imageURL']),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextBold(
                                            text: data.docs[index]['prodName'],
                                            fontSize: 14,
                                            color: Colors.black),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextRegular(
                                            text: data.docs[index]['prodDesc'],
                                            fontSize: 12,
                                            color: Colors.grey),
                                        const Divider(),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextBold(
                                            text:
                                                'Trader: ${data.docs[index]['name']}',
                                            fontSize: 14,
                                            color: Colors.black),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextRegular(
                                            text:
                                                'Contact Number: ${data.docs[index]['contactNumber']}',
                                            fontSize: 12,
                                            color: Colors.grey),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextRegular(
                                            text:
                                                'Address: ${data.docs[index]['address']}',
                                            fontSize: 12,
                                            color: Colors.grey),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Container(
                        height: 80,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        data.docs[index]['imageURL']),
                                    minRadius: 25,
                                    maxRadius: 25,
                                    backgroundColor: Colors.black),
                                const SizedBox(
                                  height: 3,
                                ),
                                TextRegular(
                                    text: data.docs[index]['prodName'],
                                    fontSize: 12,
                                    color: Colors.black),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Image.asset(
                              'assets/images/Arrow 3.png',
                              width: 80,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                    minRadius: 25,
                                    maxRadius: 25,
                                    backgroundImage: NetworkImage(
                                        data.docs[index]['myProdImage']),
                                    backgroundColor: Colors.black),
                                const SizedBox(
                                  height: 3,
                                ),
                                TextRegular(
                                    text: data.docs[index]['myProdName'],
                                    fontSize: 12,
                                    color: Colors.black),
                              ],
                            ),
                            const Expanded(
                              child: SizedBox(
                                width: 20,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                data.docs[index]['status'] == 'Pending'
                                    ? const Icon(Icons.pending)
                                    : data.docs[index]['status'] == 'Rejected'
                                        ? const Icon(Icons.warning)
                                        : const Icon(
                                            Icons.check_circle_outline),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextBold(
                                    text: data.docs[index]['status'],
                                    fontSize: 12,
                                    color: Colors.black),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                  );
                }));
          }),
    );
  }
}
