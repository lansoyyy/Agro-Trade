import 'package:agro_trading/screens/seller_screens/exchange_product/exchange_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/vendor_provider.dart';
import '../models/seller_model.dart';
import '../services/firebase_services.dart';
import '../widgets/Dashboard.dart';
import '../widgets/Exchange_pop.dart';

class CustomDrawer extends StatelessWidget {
  static const String id = 'customdrawer';
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseService _services = FirebaseService();
    final _vendorData = Provider.of<VendorProvider>(context);

    Widget _menu({String? menuTitle, IconData? icon, String? route}) {
      return ListTile(
        leading: Icon(icon),
        title: Text(menuTitle!),
        onTap: () {
          Navigator.pushReplacementNamed(context, route!);
        },
      );
    }

    return StreamBuilder<DocumentSnapshot>(
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
          } else {
            SellerModel vendor = SellerModel.fromMap(
                snapshot.data!.data() as Map<String, dynamic>);
            return Drawer(
              child: Column(
                children: [
                  Container(
                      height: 80,
                      color: Colors.blue.shade900,
                      child: Row(
                        children: [
                          DrawerHeader(
                              child: vendor.sellerName == null
                                  ? const Text('Fetching...',
                                      style: TextStyle(color: Colors.white))
                                  : Row(
                                      children: [
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              vendor.sellerName!,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                        ],
                      )),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        ExpansionTile(
                          leading: const Icon(Icons.dashboard),
                          title: const Text('Dashboard'),
                          children: [
                            _menu(menuTitle: 'Dashboard', route: Dashboard.id),
                          ],
                        ),
                        ExpansionTile(
                          leading: const Icon(Icons.cached_sharp),
                          title: const Text('Exchange'),
                          children: [
                            _menu(
                                menuTitle: 'Add Exchange Products',
                                route: ExchangePop.id),
                            _menu(
                                menuTitle: 'All Exchange Products',
                                route: ExchangeScreen.id),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  ListTile(
                    title: const Text('Sign Out'),
                    trailing: const Icon(Icons.exit_to_app),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  )
                ],
              ),
            );
          }
        });
  }
}
