import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../../../models/exchange_model.dart';
import 'card.dart';

class ExchangeScreens extends StatelessWidget {
  const ExchangeScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder<ExchangeModel>(
      query: exchangeQuerry(false),
      builder: (context, snapshot, index) {
        if (snapshot.isFetching) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}');
        }
        if (snapshot.docs.isEmpty) {
          return const Center(
            child: Text('No Products Published Yet'),
          );
        }
        return ExchangeCards(
          snapshot: snapshot,
        ); // ...
      },
    );
  }
}
