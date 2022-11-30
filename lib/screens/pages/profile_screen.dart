import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketdo/widgets/appbar_widget.dart';
import 'package:marketdo/widgets/drawer_widget.dart';
import 'package:marketdo/widgets/text_widget.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Profile'),
      body: Center(
        child: StreamBuilder<DocumentSnapshot>(
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
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                    minRadius: 50,
                    maxRadius: 50,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(data['profile']),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: TextBold(
                        text: 'Change Photo',
                        fontSize: 12,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextBold(
                      text: data['name'], fontSize: 24, color: Colors.black),
                  TextRegular(
                      text: 'Full name', fontSize: 12, color: Colors.grey),
                  const SizedBox(
                    height: 30,
                  ),
                  TextBold(
                      text: data['contactNumber'],
                      fontSize: 24,
                      color: Colors.black),
                  TextRegular(
                      text: 'Contact No.', fontSize: 12, color: Colors.grey),
                  const SizedBox(
                    height: 30,
                  ),
                  TextBold(
                      text: data['address'], fontSize: 24, color: Colors.black),
                  TextRegular(
                      text: 'Address', fontSize: 12, color: Colors.grey),
                  const SizedBox(
                    height: 30,
                  ),
                  // TextBold(text: '4.5 ☆', fontSize: 24, color: Colors.black),
                  // TextRegular(text: 'Ratings', fontSize: 12, color: Colors.grey),
                ],
              );
            }),
      ),
    );
  }
}
