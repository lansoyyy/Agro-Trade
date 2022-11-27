import 'package:flutter/material.dart';
import 'package:marketdo/widgets/text_widget.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextBold(text: '    Categories', fontSize: 16, color: Colors.black),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 175,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  return Container(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20, left: 10),
                        child: TextBold(
                            text: 'Category',
                            fontSize: 14,
                            color: Colors.black),
                      ),
                    ),
                    margin: const EdgeInsets.all(5),
                    height: 100,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                  );
                })),
          ),
          const SizedBox(
            height: 20,
          ),
          TextBold(text: '    Items', fontSize: 16, color: Colors.black),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: SizedBox(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextBold(
                                text: 'Item Name',
                                fontSize: 14,
                                color: Colors.black),
                            TextRegular(
                                text: 'Item Description',
                                fontSize: 12,
                                color: Colors.grey),
                            TextRegular(
                                text: 'Item Needed',
                                fontSize: 10,
                                color: Colors.grey),
                          ],
                        ),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}

class MessagesTab extends StatelessWidget {
  const MessagesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
