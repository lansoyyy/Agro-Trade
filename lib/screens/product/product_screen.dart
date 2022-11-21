import 'dart:io';
import 'package:agro_trading/models/seller_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import 'package:trading_app/services/cart_services.dart';

import '../../models/exchange_model.dart';
import '../../widgets/widgets.dart';

class BuyerProductScreen extends StatelessWidget {
  static const String routeName = '/product';
  static Route route({required ExchangeModel product}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BuyerProductScreen(product: product),
    );
  }

  final ExchangeModel product;
  const BuyerProductScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    //CartServices cartServices = CartServices();
    DocumentSnapshot? document;
    SellerModel user = SellerModel();
    User? seller = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: CustomAppBar(title: product.exchangeName.toString()),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(
          left: 60,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue.shade900)),
                  onPressed: () {
                    showAlertDialog(context);
                  },
                  child: (const Text('Trade'))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue.shade900)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/chathomescreen');
                    },
                    child: (const Text('Message Seller'))),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 1.5,
                viewportFraction: 0.9,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
              ),
              items: [
                HeroCarouselCard(
                  product: product,
                )
              ]),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Stack(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    alignment: Alignment.bottomCenter,
                    color: Colors.blue.withAlpha(50)),
                Container(
                    margin: const EdgeInsets.all(5.0),
                    width: MediaQuery.of(context).size.width - 10,
                    height: 50,
                    color: Colors.blue.shade900,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(product.exchangeName.toString(),
                              style: Theme.of(context).textTheme.displayLarge),
                          Text('₱${product.price}',
                              style: Theme.of(context).textTheme.displayLarge),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ExpansionTile(
              initiallyExpanded: true,
              title: Text('Product Details',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: Colors.black45)),
              children: [
                ListTile(
                  title: Text(
                    'Description: ${product.exchangeDesc.toString()}\n'
                    'Product Needed: ${product.exchangeItem.toString()}',
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ExpansionTile(
              initiallyExpanded: true,
              title: Text('Seller Information',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: Colors.black45)),
              children: [
                ListTile(
                  title: Text(
                    'Seller: ${product.seller!['name']}\n'
                    'Location: ${product.exchangeAddress}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.black, fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
  Widget onPositiveButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('OK'));
  Widget onNegativeButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
//delete product
      },
      child: const Text('CANCEL'));
  AlertDialog dialog = AlertDialog(
    actions: [onNegativeButton, onPositiveButton],
    title: const Text('Trade'),
    content: const Text(
        'Do you want to close the deal? Wait for the trader to complete your transaction'),
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      });
}
