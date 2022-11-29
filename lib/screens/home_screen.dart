import 'package:flutter/material.dart';
import 'package:marketdo/screens/tabs/home_tab.dart';
import 'package:marketdo/widgets/appbar_widget.dart';
import 'package:marketdo/widgets/drawer_widget.dart';
import 'package:marketdo/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final tabs = [const HomeTab(), const MessagesTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: const DrawerWidget(),
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: TextRegular(text: 'Home', fontSize: 18, color: Colors.black),
        centerTitle: true,
        actions: [
          _currentIndex == 0
              ? IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                )
              : const SizedBox(),
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
