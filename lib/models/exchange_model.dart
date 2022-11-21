import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/firebase_services.dart';

class ExchangeModel{
  String? exchangeName;
  String? exchangeDesc;
  String? categoryItemExch;
  List? imageUrl;
  String? exchangeAddress;
  String? exchangeItem;
  Map? seller;
  bool? trade;
  int? price;
  bool? approved;


  ExchangeModel({
    this.exchangeName,
    this.exchangeDesc,
    this.exchangeAddress,
    this.categoryItemExch,
    this.imageUrl,
    this.exchangeItem,
    this.seller,
    this.trade,
    this.price,
    this.approved

  });

//receive data from server
  factory ExchangeModel.fromMap(map)
  {
    return ExchangeModel(
        exchangeName: map['exchangeName'],
        exchangeDesc: map['exchangeDesc'],
        exchangeAddress: map ['exchangeAddress'],
        categoryItemExch: map ['categoryItemExch'],
        imageUrl: map ['imageUrl'],
        exchangeItem: map ['exchangeItem'],
        seller: map ['seller'],
        trade: map['trade'],
        price: map['price'],
        approved: map['approved']


    );
  }
//sending data to server
  Map<String, dynamic> toMap() {
    return {
      'exchangeName': exchangeName,
      'excahangeDesc': exchangeDesc,
      'exchangeAddress': exchangeAddress,
      'categoryItemExch': categoryItemExch,
      'imageUrl': imageUrl,
      'exchangeItem': exchangeItem,
      'seller': seller,
      'trade': trade,
      'price':price,
      'approved':approved

    };
  }

  static ExchangeModel fromSnapshot(DocumentSnapshot snapshot){
    ExchangeModel exchange = ExchangeModel(
        exchangeName: snapshot['exchangeName'],
        exchangeDesc: snapshot['exchangeDesc'] ,
        categoryItemExch: snapshot['categoryItemExch'],
        exchangeAddress: snapshot['exchangeAddress'],
        imageUrl: snapshot['imageUrl'] as List,
        exchangeItem: snapshot['exchangeItem'],
        seller: snapshot['seller'],
        trade: snapshot['trade'],
        price: snapshot['price'],
        approved: snapshot['approved']





    );
    return exchange;
  }
  @override

  List<Object?> get props  {
    return[

      exchangeName,
      categoryItemExch,
      exchangeDesc,
      imageUrl as List,
      exchangeAddress,
      price,
      seller,
      trade,
      approved



    ];
  }


}




FirebaseService _services = FirebaseService();
exchangeQuery(approved, {String? categories,}) {
  return FirebaseFirestore.instance.collection('exchange')
      .where('approved',isEqualTo: approved)
      .where('categoryItemExch', isEqualTo: categories)
      .orderBy('exchangeName')
      .withConverter<ExchangeModel>(
    fromFirestore: (snapshot, _) => ExchangeModel.fromSnapshot(snapshot),
    toFirestore: (exchange, _) => exchange.toMap(),
  );
}

exchangeQuerry(approved, {String? categories,}) {
  return FirebaseFirestore.instance.collection('exchange')
      .where('trade',isEqualTo: approved)
      .orderBy('exchangeName')
      .withConverter<ExchangeModel>(
    fromFirestore: (snapshot, _) => ExchangeModel.fromSnapshot(snapshot),
    toFirestore: (exchange, _) => exchange.toMap(),
  );
}