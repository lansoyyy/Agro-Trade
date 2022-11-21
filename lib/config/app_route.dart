import 'package:agro_trading/screens/seller_login_registration/seller_login.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

import '../screens/chat/chat_homescreen.dart';
import '../screens/screens.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings settings) {
    print('This is Route: ${settings.name}');

    switch (settings.name) {
      case '/':
        return HomeScreen.route();

      case Login.routeName:
        return Login.route();

      case CatalogScreen.routeName:
        return CatalogScreen.route(category: settings.arguments as Category);

      case ChatHomeScreen.routeName:
        return ChatHomeScreen.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: '/error'),
        builder: (_) => Scaffold(
              appBar: AppBar(title: const Text('ERROR')),
            ));
  }
}
