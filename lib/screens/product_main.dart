import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketdo/widgets/appbar_widget.dart';
import 'package:marketdo/widgets/button_widget.dart';
import 'package:marketdo/widgets/text_widget.dart';

class ProductMain extends StatelessWidget {
  ProductMain({Key? key}) : super(key: key);

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppbarWidget('Product Name'),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                leading: TextRegular(
                    text: 'Product Name', fontSize: 16, color: Colors.black),
                trailing:
                    TextBold(text: '₱150', fontSize: 18, color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              TextBold(
                  text: 'Product Details', fontSize: 15, color: Colors.black),
              const SizedBox(
                height: 10,
              ),
              TextRegular(
                  text: 'Description: Description',
                  fontSize: 14,
                  color: Colors.grey),
              const SizedBox(
                height: 10,
              ),
              TextRegular(
                  text: 'Preffered Product: Here',
                  fontSize: 14,
                  color: Colors.grey),
              const SizedBox(
                height: 20,
              ),
              TextBold(
                  text: 'Seller Information',
                  fontSize: 15,
                  color: Colors.black),
              const SizedBox(
                height: 10,
              ),
              TextRegular(
                  text: 'Name: John Doe', fontSize: 14, color: Colors.grey),
              const SizedBox(
                height: 10,
              ),
              TextRegular(
                  text: 'Location: Here', fontSize: 14, color: Colors.grey),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 130,
                    child: ButtonWidget(onPressed: () {}, text: 'Trade'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 130,
                    child:
                        ButtonWidget(onPressed: () {}, text: 'Message Seller'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
