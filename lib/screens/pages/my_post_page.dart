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
      body: Center(
        child: SingleChildScrollView(
          child: DataTable(columns: [
            DataColumn(
                label: TextBold(
                    text: 'Product\nImage', fontSize: 16, color: Colors.black)),
            DataColumn(
                label: TextBold(
                    text: 'Product\nName', fontSize: 16, color: Colors.black)),
            DataColumn(
                label: TextBold(
                    text: 'Delete', fontSize: 16, color: Colors.black)),
          ], rows: [
            for (int i = 0; i < 50; i++)
              DataRow(cells: [
                DataCell(Container(
                  margin: const EdgeInsets.all(2.5),
                  height: 70,
                  width: 50,
                  color: Colors.black,
                )),
                DataCell(
                  TextRegular(
                      text: 'Fish (1kl)', fontSize: 14, color: Colors.grey),
                ),
                DataCell(
                  IconButton(
                    onPressed: (() {}),
                    icon: const Icon(Icons.delete),
                  ),
                ),
              ])
          ]),
        ),
      ),
    );
  }
}
