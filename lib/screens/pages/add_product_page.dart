import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketdo/screens/home_screen.dart';
import 'package:marketdo/services/cloud_function/add_product.dart';
import 'package:marketdo/widgets/button_widget.dart';
import 'package:marketdo/widgets/text_widget.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  late String prodName;

  late String prodDesc;

  late String prefferedItem;

  var hasLoaded = false;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  late String fileName = '';
  late File imageFile;

  late String imageURL = '';
  List<String> imageUrls = [];

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

        imageUrls.add(imageURL);

        setState(() {
          hasLoaded = true;
        });

        Navigator.of(context).pop();

        print(imageUrls.toString() + ' images');
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

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: TextFormField(
                      style: const TextStyle(
                          color: Colors.black, fontFamily: 'QRegular'),
                      onChanged: (_input) {
                        prefferedItem = _input;
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
                        labelText: 'Preffered Item',
                        labelStyle: const TextStyle(
                          fontFamily: 'QRegular',
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                        child: DropdownButton(
                          underline: Container(color: Colors.transparent),
                          iconEnabledColor: Colors.black,
                          isExpanded: true,
                          value: dropDownValue,
                          items: [
                            DropdownMenuItem(
                              onTap: () {
                                productCategory = "Fruits and Vegetables";
                              },
                              child: Center(
                                  child: Row(children: const [
                                Text("Fruits and Vegetables",
                                    style: TextStyle(
                                      fontFamily: 'QRegular',
                                      color: Colors.black,
                                    ))
                              ])),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              onTap: () {
                                productCategory = "Poultry";
                              },
                              child: Center(
                                  child: Row(children: const [
                                Text("Poultry",
                                    style: TextStyle(
                                      fontFamily: 'QRegular',
                                      color: Colors.black,
                                    ))
                              ])),
                              value: 2,
                            ),
                            DropdownMenuItem(
                              onTap: () {
                                productCategory = "Meat";
                              },
                              child: Center(
                                  child: Row(children: const [
                                Text("Meat",
                                    style: TextStyle(
                                      fontFamily: 'QRegular',
                                      color: Colors.black,
                                    ))
                              ])),
                              value: 3,
                            ),
                            DropdownMenuItem(
                              onTap: () {
                                productCategory = "Fish";
                              },
                              child: Center(
                                  child: Row(children: const [
                                Text("Fish",
                                    style: TextStyle(
                                      fontFamily: 'QRegular',
                                      color: Colors.black,
                                    ))
                              ])),
                              value: 4,
                            ),
                            DropdownMenuItem(
                              onTap: () {
                                productCategory = "Crops";
                              },
                              child: Center(
                                  child: Row(children: const [
                                Text("Crops",
                                    style: TextStyle(
                                      fontFamily: 'QRegular',
                                      color: Colors.black,
                                    ))
                              ])),
                              value: 5,
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              dropDownValue = int.parse(value.toString());
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ButtonWidget(
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
                                          Icons.check_circle_outline_outlined,
                                          size: 75,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextBold(
                                            text: 'Product Added Succesfully!',
                                            fontSize: 18,
                                            color: Colors.black),
                                        const SizedBox(
                                          height: 50,
                                        ),
                                        ButtonWidget(
                                            onPressed: () {
                                              addProduct(
                                                  data['name'],
                                                  data['contactNumber'],
                                                  data['address'],
                                                  prodName,
                                                  prodDesc,
                                                  prefferedItem,
                                                  imageUrls,
                                                  productCategory);
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const HomeScreen()));
                                            },
                                            text: 'Continue'),
                                      ],
                                    )),
                              );
                            });
                      },
                      text: 'Continue'),
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
