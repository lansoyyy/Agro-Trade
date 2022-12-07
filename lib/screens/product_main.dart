import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketdo/screens/pages/add_offer_page.dart';
import 'package:marketdo/screens/tabs/convo_page.dart';
import 'package:marketdo/widgets/appbar_widget.dart';
import 'package:marketdo/widgets/button_widget.dart';
import 'package:marketdo/widgets/text_widget.dart';

class ProductMain extends StatelessWidget {
  ProductMain({Key? key}) : super(key: key);

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('products')
        .doc(box.read('prodId'))
        .snapshots();

    final Stream<DocumentSnapshot> userData1 = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
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
            appBar: AppbarWidget(data['prodName']),
            body: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        height: 200,
                        width: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              data['imageURL'],
                            ),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: TextBold(
                          text: data['prodName'],
                          fontSize: 18,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextBold(
                        text: 'Product Details',
                        fontSize: 15,
                        color: Colors.black),
                    const SizedBox(
                      height: 10,
                    ),
                    TextRegular(
                        text: 'Description: ${data['prodDesc']}',
                        fontSize: 14,
                        color: Colors.grey),
                    const SizedBox(
                      height: 10,
                    ),
                    TextRegular(
                        text: 'Preffered Product: ${data['prefferedItem']}',
                        fontSize: 14,
                        color: Colors.grey),
                    const SizedBox(
                      height: 20,
                    ),
                    TextBold(
                        text: 'Seller Information',
                        fontSize: 15,
                        color: Colors.black),
                    const SizedBox(
                      height: 10,
                    ),
                    TextRegular(
                        text: 'Name: ${data['name']}',
                        fontSize: 14,
                        color: Colors.grey),
                    const SizedBox(
                      height: 10,
                    ),
                    TextRegular(
                        text: 'Location: ${data['address']}',
                        fontSize: 14,
                        color: Colors.grey),
                    const SizedBox(
                      height: 50,
                    ),
                    StreamBuilder<DocumentSnapshot>(
                        stream: userData1,
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return const Center(
                                child: Text('Something went wrong'));
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          dynamic data1 = snapshot.data;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 130,
                                child: ButtonWidget(
                                    onPressed: () {
                                      if (data1['status'] == 'Not Verified') {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  content: TextRegular(
                                                      text:
                                                          "You cannot trade because youre account is not verified",
                                                      color: Colors.black,
                                                      fontSize: 12),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(true),
                                                      child: TextBold(
                                                          text: 'Close',
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ));
                                      } else {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AddOfferPage()));
                                      }
                                    },
                                    text: 'Trade'),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 130,
                                child: ButtonWidget(
                                    onPressed: () {
                                      if (data1['status'] == 'Not Verified') {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  content: TextRegular(
                                                      text:
                                                          "You cannot trade because youre account is not verified",
                                                      color: Colors.black,
                                                      fontSize: 12),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(true),
                                                      child: TextBold(
                                                          text: 'Close',
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ));
                                      } else {
                                        box.write('uid', data['uid']);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ConvoPage()));
                                      }
                                    },
                                    text: 'Message Seller'),
                              ),
                            ],
                          );
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
