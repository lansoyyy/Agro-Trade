import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketdo/services/cloud_function/add_message.dart';
import 'package:marketdo/widgets/appbar_widget.dart';
import 'package:marketdo/widgets/text_widget.dart';

class ConvoPage extends StatefulWidget {
  const ConvoPage({Key? key}) : super(key: key);

  @override
  State<ConvoPage> createState() => _ConvoPageState();
}

class _ConvoPageState extends State<ConvoPage> {
  final box = GetStorage();

  final messageController = TextEditingController();

  late String myName = '';

  getData1() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid);

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          myName = data['name'];
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData1();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('users')
        .doc(box.read('uid'))
        .snapshots();
    return StreamBuilder<DocumentSnapshot>(
        stream: userData,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          dynamic data = snapshot.data;
          return Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppbarWidget(data['name']),
            body: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection(FirebaseAuth.instance.currentUser!.uid)
                        .doc(box.read('uid'))
                        .collection('Messages')
                        .orderBy('dateTime')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      return Expanded(
                        child: SizedBox(
                          child: ListView.builder(
                              itemCount: snapshot.data?.size ?? 0,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ListTile(
                                    tileColor: Colors.white,
                                    title: TextRegular(
                                        text: data.docs[index]['message'],
                                        fontSize: 12,
                                        color: Colors.black),
                                    subtitle: TextRegular(
                                        text: data.docs[index]
                                            ['nameOfPersonToSend'],
                                        fontSize: 10,
                                        color: Colors.grey),
                                    trailing: TextRegular(
                                        text: data.docs[index]['time'],
                                        fontSize: 10,
                                        color: Colors.black),
                                  ),
                                );
                              }),
                        ),
                      );
                    }),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.blue[200],
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: messageController,
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'QRegular',
                        ),
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              addMessage(data['name'], messageController.text,
                                  data['id'], myName);
                              addMessage1(data['name'], messageController.text,
                                  data['id'], myName);
                              messageController.clear();
                            },
                            icon: Icon(Icons.send, color: Colors.blue[900]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
