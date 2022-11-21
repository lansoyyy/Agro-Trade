import 'package:flutter/material.dart';

import '../../../widgets/navbar.dart';
import '../../custom_drawer.dart';
import 'exchange_items.dart';

class ExchangeScreen extends StatelessWidget {
  static const String id = 'exchange-screen';
  const ExchangeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      initialIndex: 0,
      child: Scaffold(
          drawer: const CustomDrawer(),
          bottomNavigationBar: const NavBar(),
          appBar: AppBar(
            backgroundColor: Colors.blue.shade900,
            title: const Text('Exchange Items'),
            elevation: 0,
            bottom: const TabBar(
              isScrollable: true,
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 6, color: Colors.blue)),
              tabs: [
                Tab(
                  child: Text('Exchange', style: TextStyle(fontSize: 20)),
                )
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              ExchangeItems(),
            ],
          )),
    );
  }
}
