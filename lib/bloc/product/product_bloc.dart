import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/exchange_model.dart';
import '../../repositories/product/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  StreamSubscription? _productSubscription;

  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductLoading()) {
    on<LoadProduct>(_onLoadProduct);
    on<UpdateProduct>(_onUpdateProduct);
  }

  void _onLoadProduct(event, Emitter<ProductState> emit) {
    _productSubscription?.cancel();
    _productSubscription = _productRepository
        .getAllProduct()
        .listen((products) => add(UpdateProduct(products)));
  }

  void _onUpdateProduct(event, Emitter<ProductState> emit) {
    emit(ProductLoaded(products: event.products));
  }
}

/*@override
Stream<ProductState> mapEventToState(
    ProductEvent event,
    ) async* {
  if (event is LoadProduct) {
    yield* _mapLoadProductToState();
  }
  if (event is UpdateProduct) {
    yield* _mapUpdateProductToState(event);
  }
}*/