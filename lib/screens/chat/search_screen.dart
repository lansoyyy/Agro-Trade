import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/seller_model.dart';
import 'chat_screen.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen(this.user);
  SellerModel user;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  void onSearch() async {
    setState(() {
      searchResult = [];
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('seller')
        .where('sellerName', isEqualTo: searchController.text)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No User Found")));

        setState(() {
          isLoading = false;
        });
        return;
      }
      for (var user in value.docs) {
        if (user.data()['sellerEmail'] != widget.user.sellerEmail) {
          searchResult.add(user.data());
        }
      }

      setState(() {
        isLoading = false;
      });
    });
  }

  TextEditingController searchController = TextEditingController();
  List<Map> searchResult = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search your Friend"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                          hintText: "type username...",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)))),
                ),
              ),
              IconButton(
                  onPressed: () {
                    onSearch();
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          if (searchResult.isNotEmpty)
            Expanded(
                child: ListView.builder(
                    itemCount: searchResult.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.account_circle),
                        ),
                        title: Text(searchResult[index]['sellerName']),
                        subtitle: Text(searchResult[index]['sellerEmail']),
                        trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                searchController.text = '';
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                            currentUser: widget.user,
                                            friendID: searchResult[index]
                                                ['sellerId'],
                                            friendName: searchResult[index]
                                                ['sellerName'],
                                          )));
                            },
                            icon: const Icon(Icons.message)),
                      );
                    }))
          else if (isLoading == true)
            const Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}
