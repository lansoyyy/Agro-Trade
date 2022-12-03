import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketdo/screens/home_screen.dart';
import 'package:marketdo/services/cloud_function/add_notif.dart';
import 'package:marketdo/services/cloud_function/add_offer.dart';
import 'package:marketdo/widgets/appbar_widget.dart';
import 'package:marketdo/widgets/button_widget.dart';
import 'package:marketdo/widgets/text_widget.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddOfferPage extends StatefulWidget {
  const AddOfferPage({Key? key}) : super(key: key);

  @override
  State<AddOfferPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddOfferPage> {
  late String prodName;

  late String prodDesc;

  late String prefferedItem;

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
          builder: (BuildContext context) => const Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: AlertDialog(
                title: Text(
              '         Loading . . .',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quicksand'),
            )),
          ),
        );

        await firebase_storage.FirebaseStorage.instance
            .ref('Products/$fileName')
            .putFile(imageFile);
        imageURL = await firebase_storage.FirebaseStorage.instance
            .ref('Products/$fileName')
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

  var dropDownValue = 1;

  var productCategory = 'Vegetables & Fruits';

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    final Stream<DocumentSnapshot> userData1 = FirebaseFirestore.instance
        .collection('products')
        .doc(box.read('prodId'))
        .snapshots();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppbarWidget('Adding Product for Trade'),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot>(
            stream: userData,
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text('Loading'));
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
                  GestureDetector(
                    onTap: () {
                      uploadPicture('gallery');
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(hasLoaded ? Icons.check : Icons.add),
                          const SizedBox(
                            height: 20,
                          ),
                          TextBold(
                              text:
                                  hasLoaded ? 'Image Uploaded' : 'Upload Image',
                              fontSize: 14,
                              color: Colors.black),
                        ],
                      ),
                      color: Colors.white,
                      height: 180,
                      width: 150,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: TextFormField(
                      style: const TextStyle(
                          color: Colors.black, fontFamily: 'QRegular'),
                      onChanged: (_input) {
                        prodName = _input;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        labelText: 'Product Name',
                        labelStyle: const TextStyle(
                          fontFamily: 'QRegular',
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: TextFormField(
                      maxLines: 3,
                      style: const TextStyle(
                          color: Colors.black, fontFamily: 'QRegular'),
                      onChanged: (_input) {
                        prodDesc = _input;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        labelText: 'Product Description',
                        labelStyle: const TextStyle(
                          fontFamily: 'QRegular',
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  StreamBuilder<DocumentSnapshot>(
                      stream: userData1,
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(child: Text('Loading'));
                        } else if (snapshot.hasError) {
                          return const Center(
                              child: Text('Something went wrong'));
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        dynamic data1 = snapshot.data;
                        return ButtonWidget(
                            onPressed: () {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      child: SizedBox(
                                          height: 300,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons
                                                    .check_circle_outline_outlined,
                                                size: 75,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              TextBold(
                                                  text:
                                                      'Product Added Succesfully!\nWaiting for Confirmation',
                                                  fontSize: 18,
                                                  color: Colors.black),
                                              const SizedBox(
                                                height: 50,
                                              ),
                                              ButtonWidget(
                                                  onPressed: () {
                                                    addOffer(
                                                        data1['name'],
                                                        data1['contactNumber'],
                                                        data1['address'],
                                                        data1['prodName'],
                                                        data1['prodDesc'],
                                                        data1['imageURL'],
                                                        data1['uid'],
                                                        prodName,
                                                        prodDesc,
                                                        data['name'],
                                                        data['address'],
                                                        data['contactNumber'],
                                                        imageURL);
                                                    addNotif(
                                                        data['name'],
                                                        data['address'],
                                                        data['profile'],
                                                        data1['uid']);
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const HomeScreen()));
                                                  },
                                                  text: 'Continue'),
                                            ],
                                          )),
                                    );
                                  });
                            },
                            text: 'Continue');
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            }),
      ),
    );
  }
}
