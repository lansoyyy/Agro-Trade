import 'package:agro_trading/models/seller_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/firebase_services.dart';

class VendorProvider with ChangeNotifier {
  final FirebaseService _services = FirebaseService(); //firebase_service
  DocumentSnapshot? doc;
  SellerModel? sellerModel;

  getVendorData() {
    _services.seller.doc(_services.seller.id).get().then((document) {
      doc = document;
      sellerModel =
          SellerModel.fromMap(document.data() as Map<String, dynamic>);
      notifyListeners();
    });
  }
}
