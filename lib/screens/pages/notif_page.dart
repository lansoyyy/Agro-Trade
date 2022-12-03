import 'package:flutter/material.dart';
import 'package:marketdo/screens/pages/trade_request_page.dart';
import 'package:marketdo/widgets/appbar_widget.dart';
import 'package:marketdo/widgets/text_widget.dart';

class NotifPage extends StatelessWidget {
  const NotifPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppbarWidget('Notifications'),
        body: ListView.builder(itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TradeRequestPage()));
              },
              tileColor: Colors.white,
              leading: const CircleAvatar(
                minRadius: 25,
                maxRadius: 25,
                backgroundImage: AssetImage('assets/images/profile.png'),
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
                      text: 'Lance Olana', fontSize: 14, color: Colors.black),
                ],
              ),
              subtitle: TextRegular(
                  text: 'Impasugong Bukidnon',
                  fontSize: 12,
                  color: Colors.grey),
              trailing: IconButton(
                onPressed: () {
                  // FirebaseFirestore.instance
                  //                                 .collection('offer')
                  //                                 .doc(data.docs[index].id)
                  //                                 .delete();
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
          );
        }));
  }
}
