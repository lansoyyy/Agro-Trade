import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../controller/exchange_provider.dart';





class FirebaseService {
  CollectionReference homeBanner = FirebaseFirestore.instance.collection('homeBanner');

  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference seller = FirebaseFirestore.instance.collection('seller');
  CollectionReference categories = FirebaseFirestore.instance.collection('categories');
  CollectionReference product = FirebaseFirestore.instance.collection('product');
  CollectionReference exchange = FirebaseFirestore.instance.collection('exchange');
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImage(XFile? file, String? reference) async {
    File _file = File(file!.path);
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref(reference);
    await ref.putFile(_file);
    String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  Future<void> addVendor({Map<String,dynamic>?data}) {
    // Call the user's CollectionReference to add a new user
    return seller
        .add(data)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));

  }

  String formattedNumber(number){
    var f = NumberFormat("#,##,###");
    String formattedNumber = f.format(number);
    return formattedNumber;
  }



  Future uploadFile({File? image, String? reference,})async{
    firebase_storage.Reference storageReference = storage.ref().child(reference!);
    firebase_storage.UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask;
    return storageReference.getDownloadURL();
  }




  Future<void> saveToDb({Map<String,dynamic>?data,BuildContext? context}) {
    // Call the user's CollectionReference to add a new user
    return product
        .add(data)
        .then((value) => scaffold(context, "Added to Firestore"))
        .catchError((error) => scaffold(context, "Failed to add Firestore: $error"));

  }

  Future<void> saveDatabase({Map<String,dynamic>?data,BuildContext? context}) {
    // Call the user's CollectionReference to add a new user
    return exchange
        .add(data)
        .then((value) => scaffold(context, "Offered to the seller"))
        .catchError((error) => scaffold(context, "Failed to add Firestore: $error"));

  }

  Widget formField({String? label, TextInputType? inputType, void Function(String)? onChanged,
    int? minLine, int? maxLine}){
    return TextFormField(
      keyboardType:inputType,
      style: TextStyle(fontSize:20),
      decoration: InputDecoration(
        label:Text(label!),


      ),
      validator:(value){
        if(value!.isEmpty){
          return label;
        }
      },
      onChanged: onChanged,
      minLines: minLine,
      maxLines: maxLine,
    );
  }

  scaffold(context, message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(message,),action:SnackBarAction(
      label:'ok',
      onPressed: (){
        ScaffoldMessenger.of(context).clearSnackBars();
      },
    ),));
  }

  Future<void>unPublishedProduct({id}){
    return product.doc(id).delete();
  }


  Future<List> uploadData(
      {List<XFile>? images, String? ref, ExchangeProvider? provider}) async {
    var imageUrl = await Future.wait(images!.map(
          (_image) => uploadFile(image: File(_image.path), reference: ref),),
    );
    provider!.getForm(
        imageUrl: imageUrl as List
    );
    return imageUrl;
  }


}