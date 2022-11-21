import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

import '../../models/seller_model.dart';
import '../landing_screen.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool showProgress = false;
  bool visible = false;

  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  bool _isObscure = true;
  bool _isObscure2 = true;
  final List<String> _traderCat = [
    'Fishery Sector',
    'Livestock Sector',
    'Farmer',
    'Poultry'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 100,
                        child: Image.asset(
                          "assets/sell2.png",
                          fit: BoxFit.contain,
                        )),

                    //name
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.account_circle),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Full Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{10,}$');
                        if (value!.isEmpty) {
                          return ('Name cannot be Empty.');
                        }
                        if (!regex.hasMatch(value)) {
                          return ("Please Enter Valid Name ");
                        }
                        return null;
                      },
                      onChanged: (value) {},
                      keyboardType: TextInputType.name,
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField(
                        iconSize: 40,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black),
                        decoration: const InputDecoration(
                          hintText: 'Categories',
                        ),
                        items: _traderCat.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (value) {
                          categoryController.text = value.toString();
                        }),
                    const SizedBox(
                      height: 20,
                    ),

//address
                    TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.home),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Address",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{10,}$');
                        if (value!.isEmpty) {
                          return ('Address cannot be Empty.');
                        }
                        if (!regex.hasMatch(value)) {
                          return ("Please Enter Address ");
                        }
                        return null;
                      },
                      onSaved: (value) {},
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    //contact
                    TextFormField(
                      controller: contactController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.contact_phone_rounded),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Contact Number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{10,}$');
                        if (value!.isEmpty) {
                          return ('Contact Num cannot be Empty.');
                        }
                        if (!regex.hasMatch(value)) {
                          return ("Please Enter Contact Number ");
                        }
                        return null;
                      },
                      onSaved: (value) {},
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    //email
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.mail),
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Email Address",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email cannot be empty";
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                          return ("Please enter a valid email");
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {},
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    //password
                    TextFormField(
                      obscureText: _isObscure,
                      controller: passwordController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.vpn_key),
                        suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Password',
                        enabled: true,
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{6,}$');
                        if (value!.isEmpty) {
                          return "Password cannot be empty";
                        }
                        if (!regex.hasMatch(value)) {
                          return ("please enter valid password min. 6 character");
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    //confirm
                    TextFormField(
                      obscureText: _isObscure2,
                      controller: confirmpassController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.vpn_key),
                        suffixIcon: IconButton(
                            icon: Icon(_isObscure2
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscure2 = !_isObscure2;
                              });
                            }),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Confirm Password',
                        enabled: true,
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      validator: (value) {
                        if (confirmpassController.text !=
                            passwordController.text) {
                          return "Password did not match";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        MaterialButton(
                          padding: const EdgeInsets.fromLTRB(80, 5, 80, 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 5.0,
                          color: Colors.blue.shade900,
                          height: 40,
                          onPressed: () {
                            signUp(
                                emailController.text, passwordController.text);
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(
    String email,
    String password,
  ) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    //calling firestore, seller
    //sending value to firebase

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? seller = _auth.currentUser;

    SellerModel sellerModel = SellerModel();

    // writing all the values
    sellerModel.sellerEmail = seller!.email;
    sellerModel.sellerId = seller.uid;
    sellerModel.sellerName = nameController.text;
    sellerModel.sellerAddress = addressController.text;
    sellerModel.sellerContact = contactController.text;
    sellerModel.sellerCategory = categoryController.text;

    await firebaseFirestore
        .collection("seller")
        .doc(seller.uid)
        .set(sellerModel.toMap());
    Fluttertoast.showToast(msg: "Account Created Successfully!");
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const LandingScreen()),
        (route) => false);
  }
}
