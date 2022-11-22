import 'package:flutter/material.dart';

class MyTradeScreen extends StatelessWidget {
  const MyTradeScreen({Key? key}) : super(key: key);

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
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: ExpansionTile(
                    title: const Text(
                      'Product 1',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: const Text(
                      'Location: Impasugong Bukidnon',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 10,
                      ),
                    ),
                    leading: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: CircleAvatar(
                        minRadius: 25,
                        maxRadius: 25,
                        backgroundColor: Colors.black,
                      ),
                    ),
                    children: [
                      const Text(
                        'trade for:',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 10,
                        ),
                      ),
                      const ListTile(
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
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                            color: Colors.white,
                            child: const Text(
                              'Accept',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            onPressed: () {},
                          ),
                          MaterialButton(
                            color: Colors.red,
                            child: const Text(
                              'Reject',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(
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
