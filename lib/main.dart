import 'package:agro_trading/bloc/category/bloc/category_bloc.dart';
import 'package:agro_trading/config/app_route.dart';
import 'package:agro_trading/controller/exchange_provider.dart';
import 'package:agro_trading/firebase_options.dart';
import 'package:agro_trading/repositories/category/category_repository.dart';
import 'package:agro_trading/repositories/product/product_repository.dart';
import 'package:agro_trading/screens/buyer_profile_screen.dart';
import 'package:agro_trading/screens/custom_drawer.dart';
import 'package:agro_trading/screens/seller_login_registration/seller_login.dart';
import 'package:agro_trading/screens/seller_screens/exchange_product/exchange_screen.dart';
import 'package:agro_trading/screens/seller_screens/homescreen.dart';
import 'package:agro_trading/widgets/Dashboard.dart';
import 'package:agro_trading/widgets/Exchange_pop.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc/product/product_bloc.dart';
import 'config/theme.dart';

import 'controller/vendor_provider.dart';
import 'models/seller_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Provider.debugCheckInvalidValueType = null;

  BlocOverrides.runZoned(
    () {
      runApp(MultiProvider(
        providers: [
          Provider<VendorProvider>(create: (_) => VendorProvider()),
          Provider<ExchangeProvider>(create: (_) => ExchangeProvider()),
        ],
        child: MyApp(),
      ));
    },
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SellerModel user = SellerModel();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => CategoryBloc(
                  categoryRepository: CategoryRepository(),
                )..add(LoadCategories())),
        BlocProvider(
            create: (_) => ProductBloc(
                  productRepository: ProductRepository(),
                )..add(LoadProduct())),
      ],
      child: MaterialApp(
          title: 'AGROTRADE',
          debugShowCheckedModeBanner: false,
          theme: theme(),
          onGenerateRoute: AppRoute.onGenerateRoute,
          initialRoute: Login.routeName,
          routes: {
            ExchangePop.id: (context) => const ExchangePop(),
            ExchangeScreen.id: (context) => const ExchangeScreen(),
            Dashboard.id: (context) => const Dashboard(),
            SellerHomeScreen.id: (context) => const SellerHomeScreen(),
            CustomDrawer.id: (context) => const CustomDrawer(),
            BuyerProfileScreen.id: (context) => const BuyerProfileScreen(),
          }),
    );
  }
}
