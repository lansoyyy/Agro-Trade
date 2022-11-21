import 'package:agro_trading/screens/seller_login_registration/seller_registration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/seller_model.dart';
import '../services/firebase_services.dart';
import 'home_screen.dart';
import 'seller_login_registration/seller_login.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseService _services = FirebaseService();
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
          stream: _services.seller.doc(_services.user?.uid).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.data!.exists) {
              return const Registration();
            } else {
              SellerModel vendor = SellerModel.fromMap(
                  snapshot.data!.data() as Map<String, dynamic>);
              if (vendor.approved == true) {
                return HomeScreen();
              }

              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      vendor.sellerName!,
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Your application to be a vendor is sent to AgroTrade Admin \n The Admin will contact you soon.\n Have a nice day!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, color: Colors.black),
                    ),
                    OutlinedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)))),
                      child: const Text('Sign Out'),
                      onPressed: () {
                        FirebaseAuth.instance.signOut().then((value) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Login()),
                          );
                        });
                      },
                    )
                  ],
                ),
              ));
            }
          }),
    );
  }
}
