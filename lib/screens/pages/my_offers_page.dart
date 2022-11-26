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
          child: Container(
            height: 80,
            child: Row(
              children: [
                Column(
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
                Image.asset('assets/images/Arrow 3.png'),
                Column(
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
              ],
            ),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
          ),
        );
      })),
    );
  }
}
