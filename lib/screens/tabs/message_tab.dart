import 'package:flutter/material.dart';
import 'package:marketdo/widgets/text_widget.dart';

class MessageTab extends StatelessWidget {
  const MessageTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: ((context, index) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: ListTile(
          leading: const CircleAvatar(
            minRadius: 25,
            maxRadius: 25,
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
          title:
              TextBold(text: 'Lance Olana', fontSize: 14, color: Colors.black),
          subtitle:
              TextRegular(text: '08:45pm', fontSize: 10, color: Colors.grey),
          tileColor: Colors.white,
          trailing: IconButton(
            onPressed: () {
              //  FirebaseFirestore.instance
              //                               .collection('offer')
              //                               .doc(data.docs[index].id)
              //                               .delete();
            },
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        ),
      );
    }));
  }
}
