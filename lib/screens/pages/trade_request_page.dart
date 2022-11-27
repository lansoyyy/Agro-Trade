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
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 150,
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            leading: TextRegular(
                                text: 'Accept Request',
                                fontSize: 14,
                                color: Colors.black),
                            trailing: const Icon(
                              Icons.check_circle_outline_outlined,
                              color: Colors.blue,
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            leading: TextRegular(
                                text: 'Reject Request',
                                fontSize: 14,
                                color: Colors.black),
                            trailing: const Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: Container(
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextBold(
                              text: 'Trader: John',
                              fontSize: 12,
                              color: Colors.black),
                          const SizedBox(
                            height: 3,
                          ),
                          TextRegular(
                              text: '09090104355',
                              fontSize: 10,
                              color: Colors.grey),
                          const SizedBox(
                            height: 3,
                          ),
                          TextRegular(
                              text: 'Makati City',
                              fontSize: 10,
                              color: Colors.grey),
                        ],
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Divider(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextBold(
                              text: 'Trader: John',
                              fontSize: 12,
                              color: Colors.black),
                          const SizedBox(
                            height: 3,
                          ),
                          TextRegular(
                              text: '09090104355',
                              fontSize: 10,
                              color: Colors.grey),
                          const SizedBox(
                            height: 3,
                          ),
                          TextRegular(
                              text: 'Makati City',
                              fontSize: 10,
                              color: Colors.grey),
                        ],
                      ),
                      const VerticalDivider(
                        color: Colors.grey,
                      ),
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
                    ],
                  ),
                ],
              ),
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          );
        }));
  }
}
