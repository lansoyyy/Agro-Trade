import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketdo/widgets/appbar_widget.dart';
import 'package:marketdo/widgets/button_widget.dart';
import 'package:marketdo/widgets/drawer_widget.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../widgets/text_widget.dart';

class MyPostPage extends StatefulWidget {
  const MyPostPage({Key? key}) : super(key: key);

  @override
  State<MyPostPage> createState() => _MyPostPageState();
}

class _MyPostPageState extends State<MyPostPage> {
  late String prodName = '';

  late String prodDesc = '';

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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 5),
            content: Text('Uploaded Succesfully!'),
          ),
        );
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
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('My Post'),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('products')
              .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print('error');
              return const Center(child: Text('Error'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              print('waiting');
              return const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Center(
                    child: CircularProgressIndicator(
                  color: Colors.black,
                )),
              );
            }

            final data = snapshot.requireData;
            return SingleChildScrollView(
              child: Center(
                child: DataTable(columns: [
                  DataColumn(
                      label: TextBold(
                          text: 'Product\nImage',
                          fontSize: 16,
                          color: Colors.black)),
                  DataColumn(
                      label: TextBold(
                          text: 'Product\nName',
                          fontSize: 16,
                          color: Colors.black)),
                  DataColumn(
                      label: TextBold(
                          text: 'Delete', fontSize: 16, color: Colors.black)),
                ], rows: [
                  for (int i = 0; i < data.size; i++)
                    DataRow(cells: [
                      DataCell(GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  color: Colors.grey[200],
                                  height: 300,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 10, 30, 10),
                                        child: TextFormField(
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'QRegular'),
                                          onChanged: (_input) {
                                            prodName = _input;
                                          },
                                          decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            filled: true,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            hintText: data.docs[i]['prodName'],
                                            hintStyle: const TextStyle(
                                              fontFamily: 'QRegular',
                                              color: Colors.black,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 10, 30, 10),
                                        child: TextFormField(
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'QRegular'),
                                          onChanged: (_input) {
                                            prodDesc = _input;
                                          },
                                          decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            filled: true,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            hintText: data.docs[i]['prodDesc'],
                                            hintStyle: const TextStyle(
                                              fontFamily: 'QRegular',
                                              color: Colors.black,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      ButtonWidget(
                                          onPressed: () {
                                            FirebaseFirestore.instance
                                                .collection('products')
                                                .doc(data.docs[i].id)
                                                .update({
                                              'prodName': prodName == ''
                                                  ? data.docs[i]['prodName']
                                                  : prodName,
                                              'prodDesc': prodDesc == ''
                                                  ? data.docs[i]['prodDesc']
                                                  : prodDesc,
                                            });
                                            Navigator.pop(context);
                                          },
                                          text: 'Edit Post'),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(
                                image:
                                    NetworkImage(data.docs[i]['imageURL'][0]),
                                fit: BoxFit.cover),
                          ),
                          margin: const EdgeInsets.all(2.5),
                          height: 70,
                          width: 50,
                        ),
                      )),
                      DataCell(
                        TextRegular(
                            text: data.docs[i]['prodName'],
                            fontSize: 14,
                            color: Colors.grey),
                      ),
                      DataCell(
                        IconButton(
                          onPressed: (() {
                            FirebaseFirestore.instance
                                .collection('products')
                                .doc(data.docs[i].id)
                                .delete();
                          }),
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ])
                ]),
              ),
            );
          }),
    );
  }
}
