import 'package:flutter/material.dart';

import '../../widgets/appbar_widget.dart';
import '../../widgets/drawer_widget.dart';

class TradeRequestPage extends StatelessWidget {
  const TradeRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppbarWidget('Trade Request'),
      backgroundColor: Colors.grey[200],
    );
  }
}
