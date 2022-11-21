import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/exchange_model.dart';
import 'base_product_repository.dart';

class ProductRepository extends BaseProductRepository {
  final FirebaseFirestore _firebaseFirestore;

  ProductRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<ExchangeModel>> getAllProduct() {
    return _firebaseFirestore
        .collection('exchange')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ExchangeModel.fromSnapshot(doc))
          .toList();
    });
  }
}
