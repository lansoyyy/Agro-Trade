import 'package:flutter/material.dart';

class MyOfferScreen extends StatelessWidget {
  const MyOfferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        title: const Text(
          'Trades',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            return ListView.builder(
              itemBuilder: ((context, index) {
                return const Padding(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: ExpansionTile(
                    title: Text(
                      'Product 1',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      'Location: Impasugong Bukidnon',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 10,
                      ),
                    ),
                    leading: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: CircleAvatar(
                        minRadius: 25,
                        maxRadius: 25,
                        backgroundColor: Colors.black,
                      ),
                    ),
                    children: [
                      Text(
                        'trade for:',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 10,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Product 1',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        leading: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: CircleAvatar(
                            minRadius: 25,
                            maxRadius: 25,
                            backgroundColor: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Pending',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
              }),
            );
          }),
    );
  }
}
