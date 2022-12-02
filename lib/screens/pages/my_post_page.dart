import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketdo/widgets/appbar_widget.dart';
import 'package:marketdo/widgets/drawer_widget.dart';

import '../../widgets/text_widget.dart';

class MyPostPage extends StatelessWidget {
  const MyPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('My Post'),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('products')
              .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
            return SingleChildScrollView(
              child: Center(
                child: DataTable(columns: [
                  DataColumn(
                      label: TextBold(
                          text: 'Product\nImage',
                          fontSize: 16,
                          color: Colors.black)),
                  DataColumn(
                      label: TextBold(
                          text: 'Product\nName',
                          fontSize: 16,
                          color: Colors.black)),
                  DataColumn(
                      label: TextBold(
                          text: 'Delete', fontSize: 16, color: Colors.black)),
                ], rows: [
                  for (int i = 0; i < data.size; i++)
                    DataRow(cells: [
                      DataCell(Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(
                              image: NetworkImage(data.docs[i]['imageURL']),
                              fit: BoxFit.cover),
                        ),
                        margin: const EdgeInsets.all(2.5),
                        height: 70,
                        width: 50,
                      )),
                      DataCell(
                        TextRegular(
                            text: data.docs[i]['prodName'],
                            fontSize: 14,
                            color: Colors.grey),
                      ),
                      DataCell(
                        IconButton(
                          onPressed: (() {
                            FirebaseFirestore.instance
                                .collection('products')
                                .doc(data.docs[i].id)
                                .delete();
                          }),
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ])
                ]),
              ),
            );
          }),
    );
  }
}
