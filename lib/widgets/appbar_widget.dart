import 'package:flutter/material.dart';
import 'package:marketdo/widgets/text_widget.dart';

PreferredSizeWidget AppbarWidget(
  String title,
) {
  return AppBar(
    elevation: 3,
    foregroundColor: Colors.white,
    backgroundColor: Colors.green[900],
    title: TextRegular(text: title, fontSize: 18, color: Colors.white),
    centerTitle: true,
  );
}
