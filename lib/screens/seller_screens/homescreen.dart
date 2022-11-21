import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/vendor_provider.dart';

import '../../widgets/navbar.dart';
import '../custom_drawer.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'exchange_product/exchange_screen.dart';
import 'exchange_screen/exchange_product_screen.dart';


class SellerHomeScreen extends StatelessWidget {
  static const String id = 'homescreen';
  const SellerHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _vendorData = Provider.of<VendorProvider>(context);
    if (_vendorData.doc == null) {
      _vendorData.getVendorData();
    }

    return Scaffold(
        drawer: const CustomDrawer(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.blue.shade900,

          title: Text('AgroTrade Seller'),
        ),

        body: ExchangeScreens(),

        bottomNavigationBar: NavBar(),
    );
  }}