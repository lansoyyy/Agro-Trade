import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addProduct(
    String name,
    String contactNumber,
    String address,
    String prodName,
    String prodDesc,
    String prefferedItem,
    List imageURL,
    String categ,
    String unit) async {
  final docUser = FirebaseFirestore.instance.collection('products').doc();

  var dt = DateTime.now();
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
    'date': dt.month,
    'unit': unit
  };

  await docUser.set(json);
}
