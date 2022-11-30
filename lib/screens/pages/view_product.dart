import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketdo/screens/product_main.dart';
import 'package:marketdo/widgets/appbar_widget.dart';
import 'package:marketdo/widgets/text_widget.dart';

class ViewProductPage extends StatelessWidget {
  ViewProductPage({Key? key}) : super(key: key);

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppbarWidget(
        box.read('categ'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('products')
              .where('categ', isEqualTo: box.read('categ'))
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
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
                                builder: (context) => const ProductMain()));
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
          }),
    );
  }
}
