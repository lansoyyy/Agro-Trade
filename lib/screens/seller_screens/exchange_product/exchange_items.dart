import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../../../models/exchange_model.dart';
import 'exchange_card.dart';


class ExchangeItems extends StatelessWidget {
  const ExchangeItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  FirestoreQueryBuilder<ExchangeModel>(
      query: exchangeQuery(false),
      builder: (context, snapshot, _) {
        if (snapshot.isFetching) {
          return Center(child: const CircularProgressIndicator(),);
        }

        if (snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}');
        }
        if(snapshot.docs.isEmpty){
          return Center(child: Text('No Un Published Products'),);
        }
        return ExchangeCard(
          snapshot: snapshot,
        ); // ...
      },
    );
  }
}