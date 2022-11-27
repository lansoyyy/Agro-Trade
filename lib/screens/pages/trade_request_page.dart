import 'package:flutter/material.dart';
import 'package:marketdo/widgets/text_widget.dart';

import '../../widgets/appbar_widget.dart';
import '../../widgets/drawer_widget.dart';

class TradeRequestPage extends StatelessWidget {
  const TradeRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppbarWidget('Trade Request'),
        backgroundColor: Colors.grey[200],
        body: ListView.builder(itemBuilder: (context, index) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        TextBold(
                            text: 'Fish 1kl',
                            fontSize: 12,
                            color: Colors.black),
                      ],
                    ),
                    const VerticalDivider(
                      color: Colors.grey,
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Divider(),
                ),
                Row(),
              ],
            ),
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
          );
        }));
  }
}
