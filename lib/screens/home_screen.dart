import 'package:agro_trading/bloc/blocs.dart';
import 'package:agro_trading/screens/trading_screen.dart';
import 'package:agro_trading/widgets/navbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import '../widgets/widgets.dart';
import 'custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => HomeScreen());
  }

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: const CustomAppBar(title: 'AGROTRADE'),
      drawer: const CustomDrawer(),
      bottomNavigationBar: const NavBar(),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('CATEGORIES',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: Colors.black)),
            ),
          ),
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CategoryLoaded) {
                return CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 2.0,
                    viewportFraction: 0.9,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                  ),
                  items: state.categories
                      .map((category) => HeroCarouselCard(category: category))
                      .toList(),
                );
              } else {
                return const Text('Something went wrong');
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text('Daily Discover',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(color: Colors.black))),
          ),
          //ProductCard(product: Product.product[0],)
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('exchange').snapshots(),
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
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: GestureDetector(
                              onTap: () {
                                box.write('itemId', data.docs[index].id);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const TradingScreen()));
                              },
                              child: Container(
                                height: 100,
                                width: 150,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 80),
                                  child: Container(
                                    color: Colors.black38,
                                    width: 100,
                                    height: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.docs[index]['exchangeName'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            data.docs[index]['exchangeDesc'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            'Location: ${data.docs[index]['exchangeAddress']}',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.indigoAccent[900],
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        data.docs[index]['imageUrl'][0],
                                      ),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                );
              }),

          /*  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text('MOST POPULAR',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(color: Colors.black))),
          ),*/
          //ProductCard(product: Product.product[0],)
          /*  BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if(state is ProductLoading){
                return Center(child: CircularProgressIndicator());
              }if(state is ProductLoaded) {
                return ProductCarousel(
                    products: state.products
                        .where((product) => product.isPopular)
                        .toList());
              } else{return Text('Something went wrong');}
            },
          ),*/
        ],
      ),
    );
  }
}
