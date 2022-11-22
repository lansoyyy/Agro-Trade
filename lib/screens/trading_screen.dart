import 'dart:io';

import 'package:agro_trading/screens/home_screen.dart';
import 'package:agro_trading/services/functions/add_trade.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class TradingScreen extends StatefulWidget {
  @override
  State<TradingScreen> createState() => _TradingScreenState();
}

final box = GetStorage();

class _TradingScreenState extends State<TradingScreen> {
  late String itemName;

  late String desc;

  late String location;

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
            .ref('trades/$fileName')
            .putFile(imageFile);
        imageURL = await firebase_storage.FirebaseStorage.instance
            .ref('trades/$fileName')
            .getDownloadURL();

        setState(() {
          hasLoaded = true;
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

  final Stream<DocumentSnapshot> userData1 = FirebaseFirestore.instance
      .collection('exchange')
      .doc(box.read('itemId'))
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        title: const Text(
          'Offering a Trade',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Your Offer',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            hasLoaded
                ? GestureDetector(
                    onTap: () {
                      uploadPicture('gallery');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              imageURL,
                            ),
                            fit: BoxFit.cover),
                      ),
                      child: const Icon(Icons.camera_alt),
                      height: 200,
                      width: 300,
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      uploadPicture('gallery');
                    },
                    child: Container(
                      child: const Icon(Icons.camera_alt),
                      height: 200,
                      width: 300,
                      color: Colors.white,
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextFormField(
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'Quicksand'),
                onChanged: (_input) {
                  itemName = _input;
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: 'Item to trade',
                  labelStyle: const TextStyle(
                    fontFamily: 'Quicksand',
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextFormField(
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'Quicksand'),
                onChanged: (_input) {
                  desc = _input;
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: 'Description',
                  labelStyle: const TextStyle(
                    fontFamily: 'Quicksand',
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextFormField(
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'Quicksand'),
                onChanged: (_input) {
                  location = _input;
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: 'Your Location',
                  labelStyle: const TextStyle(
                    fontFamily: 'Quicksand',
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            StreamBuilder<DocumentSnapshot>(
                stream: userData1,
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: Text('Loading'));
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong'));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  dynamic data = snapshot.data;
                  return MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    minWidth: 250,
                    height: 50,
                    color: Colors.white,
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      print(imageURL);
                      print(itemName);
                      print(desc);
                      print(location);
                      print(box.read('itemId'));
                      addTrade(
                          data['seller']['uid'],
                          FirebaseAuth.instance.currentUser!.uid,
                          imageURL,
                          itemName,
                          desc,
                          location,
                          data['imageUrl'][0],
                          data['exchangeName'],
                          data['exchangeDesc'],
                          data['exchangeAddress']);

                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => HomeScreen()));
                    },
                  );
                }),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
