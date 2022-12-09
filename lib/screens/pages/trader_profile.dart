import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketdo/widgets/appbar_widget.dart';
import 'package:marketdo/widgets/text_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class TraderProfile extends StatefulWidget {
  const TraderProfile({Key? key}) : super(key: key);

  @override
  State<TraderProfile> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<TraderProfile> {
  final box = GetStorage();

  var hasLoaded = false;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  late String fileName = '';

  late File imageFile;

  late String imageURL = '';

  Future<void> uploadPicture(String inputSource) async {
    final picker = ImagePicker();
    XFile pickedImage;
    try {
      pickedImage = (await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920))!;

      fileName = path.basename(pickedImage.path);
      imageFile = File(pickedImage.path);

      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: AlertDialog(
                title: Row(
              children: const [
                CircularProgressIndicator(
                  color: Colors.black,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Loading . . .',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'QRegular'),
                ),
              ],
            )),
          ),
        );

        await firebase_storage.FirebaseStorage.instance
            .ref('Profile/$fileName')
            .putFile(imageFile);
        imageURL = await firebase_storage.FirebaseStorage.instance
            .ref('Profile/$fileName')
            .getDownloadURL();

        setState(() {
          hasLoaded = true;
        });

        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          'profile': imageURL,
        });

        Navigator.of(context).pop();
      } on firebase_storage.FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('users')
        .doc(box.read('uid'))
        .snapshots();

    return Scaffold(
      appBar: AppbarWidget("Trader's Profile"),
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
              double rate = (data['ratings'] / data['reviews']);
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

                  const SizedBox(
                    height: 10,
                  ),
                  TextBold(
                      text: 'Ratings : ' + rate.toStringAsFixed(1) + '★',
                      fontSize: 16,
                      color: Colors.amber),
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
