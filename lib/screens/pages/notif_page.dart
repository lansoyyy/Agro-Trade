import 'package:flutter/material.dart';
import 'package:marketdo/widgets/appbar_widget.dart';

class NotifPage extends StatelessWidget {
  const NotifPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppbarWidget('Notifications'),
        body: ListView.builder(itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              tileColor: Colors.white,
            ),
          );
        }));
  }
}
