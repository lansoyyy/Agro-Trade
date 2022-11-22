import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyTradeScreen extends StatelessWidget {
  const MyTradeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        title: const Text(
          'Trades',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('trade')
              .where('person1Id',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
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
                  child: ExpansionTile(
                    title: Text(
                      data.docs[index]['productOfferedName'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    leading: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: CircleAvatar(
                        minRadius: 25,
                        maxRadius: 25,
                        backgroundColor: Colors.black,
                      ),
                    ),
                    children: [
                      const Text(
                        'trade for:',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 10,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          data.docs[index]['myOfferName'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        subtitle: Text(
                          'Location: ' + data.docs[index]['myOfferLocation'],
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 10,
                          ),
                        ),
                        leading: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: CircleAvatar(
                            minRadius: 25,
                            maxRadius: 25,
                            backgroundColor: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      data.docs[index]['update']
                          ? Text(
                              data.docs[index]['status'],
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MaterialButton(
                                  color: Colors.white,
                                  child: const Text(
                                    'Accept',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('trade')
                                        .doc(data.docs[index].id)
                                        .update({
                                      'status': 'Accepted',
                                      'update': true,
                                    });
                                  },
                                ),
                                MaterialButton(
                                  color: Colors.red,
                                  child: const Text(
                                    'Reject',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('trade')
                                        .doc(data.docs[index].id)
                                        .update({
                                      'status': 'Rejected',
                                      'update': true,
                                    });
                                  },
                                ),
                              ],
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
              }),
            );
          }),
    );
  }
}
