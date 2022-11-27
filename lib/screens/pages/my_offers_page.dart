import 'package:flutter/material.dart';
import 'package:marketdo/widgets/appbar_widget.dart';
import 'package:marketdo/widgets/text_widget.dart';

import '../../widgets/drawer_widget.dart';

class MyOffersPage extends StatelessWidget {
  const MyOffersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('My Offers'),
      backgroundColor: Colors.grey[200],
      body: ListView.builder(itemBuilder: ((context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: SizedBox(
                        height: 300,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 150,
                                width: 150,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextBold(
                                  text: 'Product Name',
                                  fontSize: 14,
                                  color: Colors.black),
                              const SizedBox(
                                height: 10,
                              ),
                              TextRegular(
                                  text: 'Description',
                                  fontSize: 12,
                                  color: Colors.grey),
                              const Divider(),
                              const SizedBox(
                                height: 10,
                              ),
                              TextBold(
                                  text: 'Trader: John Doe',
                                  fontSize: 14,
                                  color: Colors.black),
                              const SizedBox(
                                height: 10,
                              ),
                              TextRegular(
                                  text: 'Contact Number: 09090104355',
                                  fontSize: 12,
                                  color: Colors.grey),
                              const SizedBox(
                                height: 10,
                              ),
                              TextRegular(
                                  text: 'Address: Makati City',
                                  fontSize: 12,
                                  color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
            child: Container(
              height: 80,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                          minRadius: 25,
                          maxRadius: 25,
                          backgroundColor: Colors.black),
                      const SizedBox(
                        height: 3,
                      ),
                      TextRegular(
                          text: '1kl fish', fontSize: 12, color: Colors.black),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    'assets/images/Arrow 3.png',
                    width: 80,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                          minRadius: 25,
                          maxRadius: 25,
                          backgroundColor: Colors.black),
                      const SizedBox(
                        height: 3,
                      ),
                      TextRegular(
                          text: '1kl fish', fontSize: 12, color: Colors.black),
                    ],
                  ),
                  const Expanded(
                    child: SizedBox(
                      width: 20,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.pending),
                      const SizedBox(
                        height: 5,
                      ),
                      TextBold(
                          text: 'Pending', fontSize: 12, color: Colors.black),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
            ),
          ),
        );
      })),
    );
  }
}
