import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart' show DateFormat, toBeginningOfSentenceCase;
import 'package:marketdo/screens/product_main.dart';
import 'package:marketdo/widgets/text_widget.dart';

class SearchMessages extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions

    return [
      IconButton(
        onPressed: () {
          if (query != '') {
            close(context, null);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 1),
                content: Text('No Input. Cannot Procceed'),
              ),
            );
          }
        },
        icon: const Icon(
          Icons.search,
          color: Colors.grey,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading

    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final box = GetStorage();

    String tdata = DateFormat("hh").format(DateTime.now());

    print(tdata);

    // TODO: implement buildSuggestions
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('products')
            .where('prodName',
                isGreaterThanOrEqualTo: toBeginningOfSentenceCase(query))
            .where('prodName',
                isLessThan: '${toBeginningOfSentenceCase(query)}z')
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
              itemBuilder: (context, index) {
                return Consumer(
                  builder: ((context, ref, child) {
                    return ListTile(
                      onTap: () {
                        box.write('prodId', data.docs[index].id);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductMain()));
                      },
                      subtitle: TextRegular(
                          text: data.docs[index]['address'],
                          fontSize: 10,
                          color: Colors.grey),
                      title: TextRegular(
                          text: data.docs[index]['prodName'],
                          fontSize: 12,
                          color: Colors.black),
                      trailing: const Icon(Icons.arrow_right),
                      tileColor: Colors.white,
                      leading: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: CircleAvatar(
                          minRadius: 25,
                          maxRadius: 25,
                          backgroundColor: Colors.green[900],
                          backgroundImage:
                              NetworkImage(data.docs[index]['imageURL']),
                        ),
                      ),
                    );
                  }),
                );
              });
        });
  }
}
