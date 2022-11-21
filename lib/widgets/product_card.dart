import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/exchange_model.dart';
import '../models/models.dart';

class ProductCard extends StatelessWidget {
  final ExchangeModel product;
  final double width;
  final double leftPosition;
  final bool isWish;
  const ProductCard(
      {Key? key,
      required this.product,
      this.width = 2.5,
      this.leftPosition = 5,
      this.isWish = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/product', arguments: product);
      },
      child: Stack(
        children: [
          SizedBox(
              width: 400,
              height: 150,
              child: CachedNetworkImage(
                imageUrl: product.imageUrl![0],
                fit: BoxFit.cover,
              )),
          Positioned(
              top: 60,
              left: leftPosition,
              child: Container(
                width: MediaQuery.of(context).size.width / 2.5,
                height: 70,
                decoration: BoxDecoration(color: Colors.black.withAlpha(50)),
              )),
          Positioned(
            top: 65,
            left: leftPosition + 5,
            child: Container(
                width: 300,
                height: 90,
                decoration: const BoxDecoration(color: Colors.black54),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.exchangeName.toString(),
                                style:
                                    Theme.of(context).textTheme.displayLarge),
                            Text('₱${product.price}',
                                style:
                                    Theme.of(context).textTheme.displaySmall),
                            Text('Product Needed:${product.exchangeItem}',
                                style:
                                    Theme.of(context).textTheme.displaySmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
