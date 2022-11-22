import 'package:cloud_firestore/cloud_firestore.dart';

Future addTrade(
    String person1Id,
    String myId,
    String myOfferImage,
    String myOfferName,
    String myOfferDesc,
    String myOfferLocation,
    String productOfferedImage,
    String productOfferedName,
    String productOfferedDesc,
    String productOfferedLocation) async {
  final docUser = FirebaseFirestore.instance.collection('trade').doc();

  final json = {
    'person1Id': person1Id,
    'myId': myId,
    'myOfferImage': myOfferImage,
    'myOfferName': myOfferName,
    'myOfferDesc': myOfferDesc,
    'myOfferLocation': myOfferLocation,
    'productOfferedImage': productOfferedImage,
    'productOfferedName': productOfferedName,
    'productOfferedDesc': productOfferedDesc,
    'productOfferedLocation': productOfferedLocation,
    'id': docUser.id,
    'status': 'Pending',
    'update': false,
  };

  await docUser.set(json);
}
