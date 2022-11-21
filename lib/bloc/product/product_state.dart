part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ExchangeModel> products;
  const ProductLoaded({this.products = const <ExchangeModel>[]});

  @override
  List<Object> get props => [products];
}
