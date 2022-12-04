import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketdo/widgets/appbar_widget.dart';

class ConvoPage extends StatelessWidget {
  ConvoPage({Key? key}) : super(key: key);

  final box = GetStorage();

  final messageController = TextEditingController();

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
                Expanded(
                  child: SizedBox(
                    child: ListView.builder(itemBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: ListTile(
                          tileColor: Colors.white,
                        ),
                      );
                    }),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.blue[200],
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'QRegular',
                        ),
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
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
