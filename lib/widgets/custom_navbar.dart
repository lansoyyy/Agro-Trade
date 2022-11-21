import 'package:flutter/material.dart';

class CustomNav extends StatelessWidget {
  const CustomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: Colors.blue.shade100,
        child: Container(
          height:60,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                IconButton(icon: Icon(Icons.home), onPressed: (){
                  Navigator.pushNamed(context,'/');
                },),
                IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){
                  Navigator.pushNamed(context,'/cart');
                },),
                IconButton(icon: Icon(Icons.person), onPressed: (){
                  Navigator.pushNamed(context,'/buyerprofilescreen');
                },),
              ]),
        )
    );
  }
}
