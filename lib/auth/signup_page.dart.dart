import 'package:flutter/material.dart';
import 'package:marketdo/widgets/button_widget.dart';
import 'package:marketdo/widgets/text_widget.dart';

import 'login_page.dart.dart';

class SignupPage extends StatelessWidget {
  SignupPage({Key? key}) : super(key: key);

  late String name;
  late String contactNumber;
  late String address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/images/signup.gif',
              height: 180,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextFormField(
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'QRegular'),
                onChanged: (_input) {
                  name = _input;
                },
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: 'Name',
                  labelStyle: const TextStyle(
                    fontFamily: 'QRegular',
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 11,
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'QRegular'),
                onChanged: (_input) {
                  contactNumber = _input;
                },
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.phone,
                    color: Colors.black,
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: 'Contact Number',
                  labelStyle: const TextStyle(
                    fontFamily: 'QRegular',
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextFormField(
                style: const TextStyle(
                    color: Colors.black, fontFamily: 'QRegular'),
                onChanged: (_input) {
                  name = _input;
                },
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.location_history_outlined,
                    color: Colors.black,
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: 'Address',
                  labelStyle: const TextStyle(
                    fontFamily: 'QRegular',
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextBold(
                text: 'Picture of your Valid ID',
                fontSize: 18,
                color: Colors.black),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add, size: 32),
                        const SizedBox(
                          height: 20,
                        ),
                        TextBold(
                            text: 'Front', fontSize: 12, color: Colors.black),
                      ],
                    ),
                    height: 180,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add, size: 32),
                        const SizedBox(
                          height: 20,
                        ),
                        TextBold(
                            text: 'Back', fontSize: 12, color: Colors.black),
                      ],
                    ),
                    height: 180,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            ButtonWidget(
                onPressed: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: SizedBox(
                              height: 300,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.check_circle_outline_outlined,
                                    size: 75,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextBold(
                                      text: 'Registered Succesfully!',
                                      fontSize: 18,
                                      color: Colors.black),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  ButtonWidget(
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()));
                                      },
                                      text: 'Continue'),
                                ],
                              )),
                        );
                      });
                },
                text: 'Register'),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
