import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketdo/screens/pages/add_product_page.dart';
import 'package:marketdo/screens/pages/notif_page.dart';
import 'package:marketdo/screens/tabs/home_tab.dart';
import 'package:marketdo/screens/tabs/message_tab.dart';
import 'package:marketdo/widgets/drawer_widget.dart';
import 'package:marketdo/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final tabs = [HomeTab(), MessageTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: const DrawerWidget(),
      appBar: AppBar(
        elevation: 3,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: TextRegular(text: 'Home', fontSize: 18, color: Colors.black),
        centerTitle: true,
        actions: [
          _currentIndex == 0
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddProductPage()));
                  },
                  icon: const Icon(Icons.add),
                )
              : const SizedBox(),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const NotifPage()));
            },
            icon: Badge(
              badgeContent: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('notif')
                      .where('userId',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
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
                    return TextRegular(
                        text: data.size.toString(),
                        fontSize: 12,
                        color: Colors.white);
                  }),
              child: const Icon(Icons.notifications),
            ),
          ),
        ],
      ),
      body: SafeArea(child: tabs[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.shifting,
        iconSize: 25,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            label: 'Home',
            backgroundColor: Colors.green[400],
          ),
          BottomNavigationBarItem(
              icon: const Icon(
                Icons.message,
                color: Colors.white,
              ),
              backgroundColor: Colors.blue[400],
              label: 'Messages'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
