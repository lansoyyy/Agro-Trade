import 'package:cloud_firestore/cloud_firestore.dart';

Future addNotif(
  String name,
  String address,
  String profilePicture,
  String userId,
) async {
  final docUser = FirebaseFirestore.instance.collection('notif').doc();

  final json = {
    'name': name,
    'address': address,
    'id': docUser.id,
    'profilePicture': profilePicture,
    'userId': userId,
    'dateTime': DateTime.now(),
  };

  await docUser.set(json);
}
