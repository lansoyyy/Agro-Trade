import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Home'),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextBold(text: 'Categories', fontSize: 16, color: Colors.black),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 175,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) {
                    return Container(
                      child: Center(
                        child: TextBold(
                            text: 'Insert Here',
                            fontSize: 24,
                            color: Colors.white),
                      ),
                      margin: const EdgeInsets.all(5),
                      height: 100,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5)),
                    );
                  })),
            ),
            const SizedBox(
              height: 20,
            ),
            TextBold(text: 'Items', fontSize: 16, color: Colors.black),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SizedBox(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
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
          BottomNavigationBarItem(
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              backgroundColor: Colors.red[400],
              label: 'Profile'),
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
