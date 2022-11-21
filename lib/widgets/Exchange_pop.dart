import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../controller/exchange_provider.dart';
import '../models/seller_model.dart';
import '../screens/custom_drawer.dart';
import '../services/firebase_services.dart';
import 'custom_app_bar.dart';
import 'navbar.dart';

class ExchangePop extends StatefulWidget {
  static const String id = 'exchange-pop';
  const ExchangePop({Key? key}) : super(key: key);

  @override
  State<ExchangePop> createState() => _ExchangePopState();
}

class _ExchangePopState extends State<ExchangePop> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile>? _imageFiles = [];
  Future<List<XFile>?> _pickImage() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    return images;
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final FirebaseService _services = FirebaseService();
    final provider = Provider.of<ExchangeProvider>(context);
    final List<String> _categories = [
      'Fish',
      'Meat',
      'Vegetables & Fruits',
      'Poultry'
    ];
    return StreamBuilder<DocumentSnapshot>(
        stream: _services.seller.doc(_services.user!.uid).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            SellerModel vendor = SellerModel.fromMap(
                snapshot.data!.data() as Map<String, dynamic>);

            return Form(
                key: _formKey,
                child: Scaffold(
                    bottomNavigationBar: const NavBar(),
                    drawer: const CustomDrawer(),
                    appBar: const CustomAppBar(
                      title: 'Exchange Porduct',
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        children: [
                          TextButton(
                            child: const Text('Add Product Image'),
                            onPressed: () {
                              _pickImage().then((value) {
                                var list = value!.forEach((image) {
                                  setState(() {
                                    provider.getImageFile(image);
                                  });
                                });
                              });
                            },
                          ),
                          Center(
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount: provider.images!.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                          onLongPress: () {
                                            setState(() {
                                              provider.images!.removeAt(index);
                                            });
                                          },
                                          child: provider.images == null
                                              ? const Center(
                                                  child: Text(
                                                      'No Images selected'))
                                              : Image.file(File(provider
                                                  .images![index].path))),
                                    );
                                  })),
                          _services.formField(
                              label: 'Product Name',
                              inputType: TextInputType.name,
                              onChanged: (value) {
                                //save in provider
                                provider.getForm(
                                  exchangeName: value,
                                );
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField(
                              iconSize: 40,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                              decoration: const InputDecoration(
                                hintText: 'Categories',
                              ),
                              items: _categories.map((category) {
                                return DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                );
                              }).toList(),
                              onChanged: (value) {
                                provider.getForm(
                                  categoryItemExch: value.toString(),
                                );
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          _services.formField(
                              label: 'Product Description',
                              inputType: TextInputType.name,
                              onChanged: (value) {
                                //save in provider
                                provider.getForm(
                                  exchangeDesc: value,
                                );
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          _services.formField(
                              label: 'Location',
                              inputType: TextInputType.name,
                              onChanged: (value) {
                                //save in provider
                                provider.getForm(
                                  exchangeAddress: value,
                                );
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          _services.formField(
                              label: 'Item to Exchange',
                              inputType: TextInputType.name,
                              onChanged: (value) {
                                //save in provider
                                provider.getForm(
                                  exchangeItem: value,
                                );
                              }),
                        ],
                      ),
                    ),
                    persistentFooterButtons: [
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.blue.shade900)),
                          child: const Text(
                            'Make Offer',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              provider.getForm(seller: {
                                'name': vendor.sellerName!,
                                'uid': _services.user!.uid,
                              });

                              _services
                                  .uploadData(
                                      images: provider.images,
                                      ref:
                                          'exchange/${provider.exchangeData!['exchangeName']}',
                                      provider: provider)
                                  .then((value) => _services
                                          .saveDatabase(
                                              data: provider.exchangeData,
                                              context: context)
                                          .then((value) {
                                        EasyLoading.dismiss();
                                        setState(() {
                                          provider.clearProduct();
                                        });
                                      }));
                            }
                          })
                    ]));
          }
        });
  }
}
