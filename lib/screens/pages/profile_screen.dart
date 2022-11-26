import 'package:flutter/material.dart';
import 'package:marketdo/widgets/appbar_widget.dart';
import 'package:marketdo/widgets/drawer_widget.dart';
import 'package:marketdo/widgets/text_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Profile'),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const CircleAvatar(
              minRadius: 50,
              maxRadius: 50,
              backgroundColor: Colors.grey,
            ),
            TextButton(
              onPressed: () {},
              child: TextBold(
                  text: 'Change Photo', fontSize: 12, color: Colors.black),
            ),
            const SizedBox(
              height: 30,
            ),
            TextBold(text: 'John Doe', fontSize: 24, color: Colors.black),
            TextRegular(text: 'Full name', fontSize: 12, color: Colors.grey),
            const SizedBox(
              height: 30,
            ),
            TextBold(text: '09090104355', fontSize: 24, color: Colors.black),
            TextRegular(text: 'Contact No.', fontSize: 12, color: Colors.grey),
            const SizedBox(
              height: 30,
            ),
            TextBold(text: 'Makati City', fontSize: 24, color: Colors.black),
            TextRegular(text: 'Address', fontSize: 12, color: Colors.grey),
            const SizedBox(
              height: 30,
            ),
            TextBold(text: '4.5 ☆', fontSize: 24, color: Colors.black),
            TextRegular(text: 'Ratings', fontSize: 12, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
