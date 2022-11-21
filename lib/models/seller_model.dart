import 'package:cloud_firestore/cloud_firestore.dart';

class SellerModel{
  String? sellerId;
  String? sellerName;
  String? sellerAddress;
  String? sellerContact;
  String? sellerEmail;
  bool? approved;
  String? sellerImage;
  String? sellerCategory;

  SellerModel({
    this.sellerId,
    this.sellerName,
    this.sellerAddress,
    this.sellerContact,
    this.sellerEmail,
    this.sellerImage,
    this.approved,
    this.sellerCategory
  });

//receive data from server
  factory SellerModel.fromMap(Map<String, dynamic>map)
  {
    return SellerModel(
        approved: map['approved'],
        sellerId: map['sellerId'] as String,
        sellerEmail: map['sellerEmail'],
        sellerName: map ['sellerName'],
        sellerAddress: map ['sellerAddress'],
        sellerContact: map ['sellerContact'],
        sellerImage: map ['sellerImage'],
        sellerCategory: map['sellerCategory']

    );
  }
//sending data to server
  Map<String, dynamic> toMap() {
    return {
      'approved':false,
      'sellerId': sellerId,
      'sellerEmail': sellerEmail,
      'sellerName': sellerName,
      'sellerAddress': sellerAddress,
      'sellerContact': sellerContact,
      'sellerImage': sellerImage,
      'sellerCategory': sellerCategory
    };
  }

  factory SellerModel.fromDocument(DocumentSnapshot doc)
  {
    return SellerModel(
      approved: doc.data().toString().contains("approve"),
      sellerId: doc.data().toString().contains('sellerId') ? doc.get('sellerId') : '',
      sellerEmail: doc.data().toString().contains('sellerEmail') ? doc.get('sellerEmail') : '',
      sellerName: doc.data().toString().contains('sellerName') ? doc.get('sellerName') : '',
      sellerAddress: doc.data().toString().contains('sellerAddress') ? doc.get('sellerAddress') : '',
      sellerContact: doc.data().toString().contains('sellerContact') ? doc.get('sellerContact') : '',
      sellerImage: doc.data().toString().contains('sellerImage') ? doc.get('sellerImage') : '',
      sellerCategory: doc.data().toString().contains('sellerCategory') ? doc.get('sellerCategory') : '',
    );
  }


}