import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

Future addMessage(
  String nameOfPersonToSend,
  String message,
  String receiverId,
  String myName,
) async {
  final docUser = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.uid)
      .doc(receiverId)
      .collection('Messages')
      .doc();

  final box = GetStorage();

  final docUser1 = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.uid)
      .doc(receiverId);

  String tdata = DateFormat("hh:mm a").format(DateTime.now());

  final json = {
    'nameOfPersonToSend': nameOfPersonToSend,
    'message': message,
    'myName': myName,
    'id': docUser.id,
    'time': tdata,
    'dateTime': DateTime.now(),
  };

  final json1 = {
    'nameOfPersonToSend': nameOfPersonToSend,
    'message': message,
    'myName': myName,
    'id': docUser.id,
    'time': tdata,
    'dateTime': DateTime.now(),
  };

  await docUser1.set(json1);

  await docUser.set(json);
}

Future addMessage1(
  String nameOfPersonToSend,
  String message,
  String receiverId,
  String myName,
) async {
  final docUser = FirebaseFirestore.instance
      .collection(receiverId)
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Messages')
      .doc();

  final box = GetStorage();

  final docUser1 = FirebaseFirestore.instance
      .collection(receiverId)
      .doc(FirebaseAuth.instance.currentUser!.uid);

  String tdata = DateFormat("hh:mm a").format(DateTime.now());

  final json = {
    'nameOfPersonToSend': nameOfPersonToSend,
    'message': message,
    'myName': myName,
    'id': docUser.id,
    'time': tdata,
    'dateTime': DateTime.now(),
  };

  final json1 = {
    'nameOfPersonToSend': nameOfPersonToSend,
    'message': message,
    'myName': myName,
    'id': docUser.id,
    'time': tdata,
    'dateTime': DateTime.now(),
  };

  await docUser1.set(json1);

  await docUser.set(json);
}
