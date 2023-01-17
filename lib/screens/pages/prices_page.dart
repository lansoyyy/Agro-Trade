import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marketdo/widgets/appbar_widget.dart';
import 'package:marketdo/widgets/drawer_widget.dart';
import 'package:marketdo/widgets/text_widget.dart';

class PricesPage extends StatefulWidget {
  @override
  State<PricesPage> createState() => _PricesPageState();
}

class _PricesPageState extends State<PricesPage> {
  var categList = [
    'All',
    'Vegetables and Fruits',
    'Poultry',
    'Meat',
    'Fish',
    'Crop'
  ];

  int value1 = 0;

  late String filter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Price Guidelines'),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          TextRegular(text: 'Filter Prices', fontSize: 8, color: Colors.grey),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
              child: Container(
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButton(
                  dropdownColor: Colors.white,
                  underline: Container(color: Colors.transparent),
                  iconEnabledColor: Colors.black,
                  isExpanded: true,
                  value: value1,
                  items: [
                    for (int i = 0; i < categList.length; i++)
                      DropdownMenuItem(
                        onTap: () {
                          filter = categList[i];
                        },
                        child: Center(
                            child: Row(children: [
                          Text("    " + categList[i],
                              style: const TextStyle(
                                fontFamily: 'QRegular',
                                color: Colors.black,
                              ))
                        ])),
                        value: i,
                      ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      value1 = int.parse(value.toString());
                    });
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: filter == 'All'
                  ? FirebaseFirestore.instance.collection('Prices').snapshots()
                  : FirebaseFirestore.instance
                      .collection('Prices')
                      .where('categ', isEqualTo: filter)
                      .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print('error');
                  return const Center(child: Text('Error'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('waiting');
                  return const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    )),
                  );
                }

                final data = snapshot.requireData;
                return Expanded(
                  child: SizedBox(
                    child: ListView.builder(
                      itemCount: snapshot.data?.size ?? 0,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: Card(
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextBold(
                                      text: data.docs[index]['name'],
                                      fontSize: 14,
                                      color: Colors.black),
                                  TextRegular(
                                      text: 'Product',
                                      fontSize: 10,
                                      color: Colors.grey),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextBold(
                                      text: '₱' + data.docs[index]['price'],
                                      fontSize: 14,
                                      color: Colors.green[900]!),
                                  TextRegular(
                                      text: 'Retail Price',
                                      fontSize: 10,
                                      color: Colors.grey),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
