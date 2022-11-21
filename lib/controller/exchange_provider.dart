import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


import '../models/exchange_model.dart';


class ExchangeProvider with ChangeNotifier{
  User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? exchangeData={
    'trade':false
  };
  final List<XFile>? images = [];

  getForm({
    String? exchangeName,
    String? exchangeDesc,
    String? categoryItemExch,
    List? imageUrl,
    String? exchangeAddress,
    String? exchangeItem,
    Map? seller,
    String? exchangeId



  }){
    if(exchangeName!=null){
      exchangeData!['exchangeName'] = exchangeName;
    }
    if(exchangeDesc!=null){
      exchangeData!['exchangeDesc'] = exchangeDesc;
    }
    if(exchangeAddress!=null){
      exchangeData!['exchangeAddress'] = exchangeAddress;
    }
    if(imageUrl!=null){
      exchangeData!['imageUrl'] = imageUrl;
    }
    if(categoryItemExch!=null){
      exchangeData!['categoryItemExch'] = categoryItemExch;
    }
    if(exchangeItem!=null){
      exchangeData!['exchangeItem'] = exchangeItem;
    }
    if(seller!=null){
      exchangeData!['seller'] = seller;
    }
    if(exchangeId!=null){
      exchangeData!['exchangeId'] = exchangeId;
    }

    notifyListeners();
  }

  getImageFile(XFile image){
    images!.add(image);
    notifyListeners();
  }
  clearProduct(){
    exchangeData!.clear();
    images!.clear();
    exchangeData!['trade']=false;
    notifyListeners();

  }

  static List<ExchangeModel> _exchangeList = [];

  List<ExchangeModel> get getProducts {
    return _exchangeList;
  }







}


