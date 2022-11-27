import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marketdo/auth/login_page.dart.dart';

class SplashScreen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () async {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Image(
                      width: 250,
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 75, right: 75),
                    child: LinearProgressIndicator(
                      color: Colors.blue,
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
