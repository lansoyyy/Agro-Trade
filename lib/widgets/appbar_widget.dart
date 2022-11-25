import 'package:flutter/material.dart';
import 'package:marketdo/widgets/text_widget.dart';

PreferredSizeWidget AppbarWidget(
  String title,
) {
  return AppBar(
    elevation: 0,
    foregroundColor: Colors.black,
    backgroundColor: Colors.white,
    title: TextRegular(text: title, fontSize: 18, color: Colors.black),
    centerTitle: true,
  );
}
