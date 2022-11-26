import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';
import 'package:marketdo/screens/home_screen.dart';
import 'package:marketdo/screens/pages/profile_screen.dart';
import 'package:marketdo/widgets/text_widget.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<DrawerWidget> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Drawer(
        child: ListView(
          padding: const EdgeInsets.only(top: 0),
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
              accountEmail: TextRegular(
                  text: 'johndoe@gmail.com', fontSize: 12, color: Colors.grey),
              accountName: TextBold(
                text: 'John Doe',
                fontSize: 18,
                color: Colors.grey,
              ),
              currentAccountPicture: const Padding(
                padding: EdgeInsets.all(5.0),
                child: CircleAvatar(
                  minRadius: 50,
                  maxRadius: 50,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: TextBold(
                text: 'Home',
                fontSize: 12,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: TextBold(
                text: 'Profile',
                fontSize: 12,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfileScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: TextBold(
                text: 'My Post',
                fontSize: 12,
                color: Colors.black,
              ),
              onTap: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) => ChatRoom()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.change_circle_outlined),
              title: TextBold(
                text: 'Trade Request',
                fontSize: 12,
                color: Colors.black,
              ),
              onTap: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) => ChatRoom()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: TextBold(
                text: 'Logout',
                fontSize: 12,
                color: Colors.black,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text(
                            'Logout Confirmation',
                            style: TextStyle(
                                fontFamily: 'QBold',
                                fontWeight: FontWeight.bold),
                          ),
                          content: const Text(
                            'Are you sure you want to Logout?',
                            style: TextStyle(fontFamily: 'QRegular'),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text(
                                'Close',
                                style: TextStyle(
                                    fontFamily: 'QRegular',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                // Navigator.of(context).pushReplacement(
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const LogInPage()));
                              },
                              child: const Text(
                                'Continue',
                                style: TextStyle(
                                    fontFamily: 'QRegular',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
