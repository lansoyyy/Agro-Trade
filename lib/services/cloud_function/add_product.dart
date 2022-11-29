import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addProduct(
  String name,
  String contactNumber,
  String address,
  String prodName,
  String prodDesc,
  String prefferedItem,
  String imageURL,
  String categ,
) async {
  final docUser = FirebaseFirestore.instance.collection('products').doc();

  final json = {
    'name': name,
    'prodName': prodName,
    'prodDesc': prodDesc,
    'prefferedItem': prefferedItem,
    'imageURL': imageURL,
    'contactNumber': contactNumber,
    'address': address,
    'categ': categ,
    'id': docUser.id,
    'uid': FirebaseAuth.instance.currentUser!.uid,
  };

  await docUser.set(json);
}
