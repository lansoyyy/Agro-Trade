import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketdo/screens/pages/view_product.dart';
import 'package:marketdo/screens/product_main.dart';
import 'package:marketdo/widgets/text_widget.dart';

class HomeTab extends StatelessWidget {
  HomeTab({Key? key}) : super(key: key);

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextBold(text: '    Categories', fontSize: 16, color: Colors.black),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('categories')
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
                return SizedBox(
                  height: 175,
                  child: ListView.builder(
                      itemCount: snapshot.data?.size ?? 0,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {
                            box.write('categ', data.docs[index]['name']);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ViewProductPage()));
                          },
                          child: Container(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                width: double.infinity,
                                color: Colors.black38,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20, left: 10, top: 10),
                                  child: TextBold(
                                      text: data.docs[index]['name'],
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            margin: const EdgeInsets.all(5),
                            height: 100,
                            width: 250,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    data.docs[index]['imageUrl'],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        );
                      })),
                );
              }),
          const SizedBox(
            height: 20,
          ),
          TextBold(text: '    Items', fontSize: 16, color: Colors.black),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('products').snapshots(),
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
                    child: GridView.builder(
                        itemCount: snapshot.data?.size ?? 0,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
                              onTap: () {
                                box.write('prodId', data.docs[index].id);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ProductMain()));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextBold(
                                        text: data.docs[index]['prodName'],
                                        fontSize: 14,
                                        color: Colors.white),
                                    SizedBox(
                                      width: 150,
                                      child: TextRegular(
                                          text: data.docs[index]['prodDesc'],
                                          fontSize: 12,
                                          color: Colors.white),
                                    ),
                                    TextRegular(
                                        text: data.docs[index]['prefferedItem'],
                                        fontSize: 10,
                                        color: Colors.white),
                                  ],
                                ),
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      opacity: 120,
                                      image: NetworkImage(
                                        data.docs[index]['imageURL'],
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                          );
                        }),
                  ),
                );
              })
        ],
      ),
    );
  }
}
