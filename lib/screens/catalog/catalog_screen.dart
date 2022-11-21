import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product/product_bloc.dart';
import '../../models/exchange_model.dart';
import '../../models/models.dart';
import '../../services/database_services.dart';
import '../../widgets/navbar.dart';
import '../../widgets/widgets.dart';

class CatalogScreen extends StatelessWidget {
  static const String routeName = '/catalog';
  static Route route({required Category category}) {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => CatalogScreen(category: category));
  }

  final Category category;

  const CatalogScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: category.name),
        bottomNavigationBar: const NavBar(),
        body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProductLoaded) {
            final List categoryProduct = state.products
                .where((product) => product.categoryItemExch == category.name)
                .toList();
            return ListView.builder(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              itemCount: categoryProduct.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                    child: ProductCard(
                        product: categoryProduct[index], width: 2.2));
              },
            );
          } else {
            return const Text('Something went wrong! ');
          }
        }));
  }
}
