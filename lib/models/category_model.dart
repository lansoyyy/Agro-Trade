import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String name;
  final String imageUrl;

  const Category({
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [name, imageUrl];

  static Category fromSnapShot(DocumentSnapshot snapshot) {
    Category category =
        Category(name: snapshot['name'], imageUrl: snapshot['imageUrl']);
    return category;
  }

  static List<Category> categories = [
    Category(
        name: 'Crustaceans',
        imageUrl:
            'https://media.istockphoto.com/photos/raw-seafood-cocktail-close-up-picture-id586165510?k=20&m=586165510&s=612x612&w=0&h=k4Z5Vvzi9XxOR8xbxhL8W-9pyQ63c_UTmAH0gyvbcHY='),
    Category(
        name: 'Fresh Water',
        imageUrl:
            'https://cdn.britannica.com/28/220228-050-01DFA7B1/seafood-market-Istanbul-Turkey.jpg'),
    Category(
        name: 'Mollusks',
        imageUrl:
            'https://manoa.hawaii.edu/exploringourfluidearth/sites/default/files/styles/half-page-width/public/Fig3.61A-Hardshell_clams.jpg?itok=lGirqntb'),
  ];
}
