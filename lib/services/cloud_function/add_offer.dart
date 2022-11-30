import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addOffer(
  String name,
  String contactNumber,
  String address,
  String prodName,
  String prodDesc,
  String imageURL,
  String userId,
  String myProdName,
  String myProdDesc,
  String myName,
  String myAddress,
  String myContactNumber,
  String myProdImage,
) async {
  final docUser = FirebaseFirestore.instance.collection('offer').doc();

  final json = {
    'name': name,
    'prodName': prodName,
    'prodDesc': prodDesc,
    'imageURL': imageURL,
    'contactNumber': contactNumber,
    'address': address,
    'id': docUser.id,
    'user_id': userId,
    'my_id': FirebaseAuth.instance.currentUser!.uid,
    'myName': myName,
    'myAddress': myAddress,
    'myContactNumber': myContactNumber,
    'status': 'Pending',
    'myProdImage': myProdImage,
    'myProdName': myProdName,
    'myProdDesc': myProdDesc,
  };

  await docUser.set(json);
}
