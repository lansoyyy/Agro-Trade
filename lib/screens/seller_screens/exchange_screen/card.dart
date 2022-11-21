import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import '../../../../services/firebase_services.dart';
import '../../../models/exchange_model.dart';

class ExchangeCards extends StatefulWidget {
  const ExchangeCards({Key? key, this.snapshot}) : super(key: key);
  final FirestoreQueryBuilderSnapshot? snapshot;

  @override
  State<ExchangeCards> createState() => _ExchangeCardsState();
}

class _ExchangeCardsState extends State<ExchangeCards> {

  List<ExchangeModel> _exchangeList =[];


  @override
  void initState(){
    getExchangeList();
    super.initState();
  }
  getExchangeList(){
    return widget.snapshot!.docs.forEach((element) {
      ExchangeModel exchange = element.data();
      setState(() {
        _exchangeList.add(
            ExchangeModel(
              exchangeName: exchange.exchangeName,
              exchangeDesc: exchange.exchangeDesc,
              exchangeAddress: exchange.exchangeAddress,
              categoryItemExch: exchange.categoryItemExch,
              imageUrl: exchange.imageUrl,
              exchangeItem: exchange.exchangeItem,



            )
        );
      });
    });
  }
  Widget build(BuildContext context) {
    FirebaseService services = FirebaseService();
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
                children: [
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: widget.snapshot!.docs.length,
                      itemBuilder: (context, index) {
                        ExchangeModel exchange = widget.snapshot!.docs[index].data();
                        return Card(
                          child: Row(
                            children: [

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Product Name: ${exchange.exchangeName.toString()}',
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.black),),

                                    Text('Description: ${exchange.exchangeDesc.toString()}',
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.black),),

                                    Text('Exchange Item: ${exchange.exchangeItem.toString()}',
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.black),),

                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(onPressed: (){}, child: Text('Trade')),
                                        ),
                                        ElevatedButton(onPressed: (){}, child: Text('Message Seller'))
                                      ],
                                    ),






                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                  )
                ]
            )
        )
    );
  }
}