import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class BuyerProfileScreen extends StatefulWidget {
  static const String id ='buyer-profile-screen';
  const BuyerProfileScreen({Key? key}) : super(key: key);


  @override
  State<BuyerProfileScreen> createState() => _BuyerProfileScreenState();
}

class _BuyerProfileScreenState extends State<BuyerProfileScreen> {
  TextEditingController ?_nameController;
  TextEditingController ?_emailController;
  TextEditingController ?_contactController;
  TextEditingController ?_addressController;

  setDataToTextField(data) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.person),
            labelText: 'Name ',
          ),
          controller: _nameController = TextEditingController(text: data["name"]),
        ),
        SizedBox(height: 20,),
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.email),
            labelText: 'Email Address ',
          ),
          controller: _emailController = TextEditingController(text: data["email"]),
        ),
        SizedBox(height: 20,),
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.contact_phone),
            labelText: 'Contact Number ',
          ),
          controller: _contactController = TextEditingController(text: data["contact"]),
        ),
        SizedBox(height: 20,),
        TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.place),
            labelText: 'Address',
          ),
          controller: _addressController = TextEditingController(text: data["address"]),
        ),
        SizedBox(height: 20,),
        ElevatedButton(onPressed: ()=>updateData(), child: Text("Update"))
      ],
    );
  }
  updateData() {
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.uid).update(
        {
          "sellerName": _nameController!.text,
          "sellerEmail": _emailController!.text,
          "sellerContact": _contactController!.text,
          "sellerAddress": _addressController!.text,

        }

    ).then((value) => EasyLoading.showSuccess('Updated Successfully!'));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue.shade900,
        title: Center(child: const Text('ACCOUNT', style: TextStyle(fontSize: 24),)),
        elevation: 0,


      ),
      body: SafeArea(
        child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            var data = snapshot.data;

            if (data==null){
              return Center(child: LinearProgressIndicator(),);
            }
            return setDataToTextField(data);
          },

        ),
      ),

      ),
      persistentFooterButtons: [
        ElevatedButton(
          child: Text('Sign Out'),
          onPressed:  (){
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, '/onboarding');
          },

        )
      ]


    );
  }
}