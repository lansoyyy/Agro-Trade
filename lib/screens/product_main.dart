import 'package:flutter/material.dart';
import 'package:marketdo/widgets/appbar_widget.dart';

class ProductMain extends StatelessWidget {
  const ProductMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppbarWidget('Product Name'),
    );
  }
}
