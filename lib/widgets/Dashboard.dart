import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../models/exchange_model.dart';


class Dashboard extends StatefulWidget {
  static const String id ='dashboard';
  const Dashboard({Key? key, this.snapshot, this.snap}) : super(key: key);
  final FirestoreQueryBuilderSnapshot? snapshot;
  final FirestoreQueryBuilderSnapshot? snap;
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<ExchangeModel> _exchangeList =[];

  @override

  void initState(){
    getExchangeList();

    super.initState();
  }
  getExchangeList(){
    return widget.snapshot?.docs.forEach((element) {
      ExchangeModel exchange = element.data();
      setState(() {
        _exchangeList.add(
            ExchangeModel(
              exchangeName: exchange.exchangeName,
              exchangeDesc: exchange.exchangeDesc,
              exchangeAddress: exchange.exchangeAddress,
              categoryItemExch: exchange.categoryItemExch,
              imageUrl: exchange.imageUrl,


            )
        );
      });
    });
  }




  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
        height: MediaQuery.of(context).size.height,
    child: Column(
    children: [
    Container(
    color: Colors.blue.shade900,
    width: MediaQuery.of(context).size.width,
    height: 30,
    child: Padding(
    padding: const EdgeInsets.all(5.0),
    child: Text('Total Products: ${widget.snapshot?.docs.length}', style: TextStyle(fontSize: 20, color: Colors.white),),
    ),
    ),
      Container(
        color: Colors.blue.shade900,
        width: MediaQuery.of(context).size.width,
        height: 30,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text('Total Exchange Product: ${widget.snap?.docs.length}', style: TextStyle(fontSize: 20, color: Colors.white),),
        ),
      ),
    ])));
  }
}
