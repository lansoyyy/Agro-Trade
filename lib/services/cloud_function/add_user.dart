import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addUser(
  String name,
  String contactNumber,
  String address,
  String idfront,
  String idback,
  String email,
) async {
  final docUser = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  final json = {
    'name': name,
    'email': email,
    'contactNumber': contactNumber,
    'address': address,
    'idfront': idfront,
    'idback': idback,
    'id': docUser.id,
  };

  await docUser.set(json);
}
