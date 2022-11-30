import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketdo/widgets/appbar_widget.dart';

class ViewProductPage extends StatelessWidget {
  ViewProductPage({Key? key}) : super(key: key);

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppbarWidget(box.read('categ')),
    );
  }
}
