import '../../models/exchange_model.dart';

abstract class BaseProductRepository {
  Stream<List<ExchangeModel>> getAllProduct();
}
