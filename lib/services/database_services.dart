import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class DatabaseService {
  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference productList = FirebaseFirestore.instance.collection(
      'product');
  CollectionReference seller = FirebaseFirestore.instance.collection('seller');













}
