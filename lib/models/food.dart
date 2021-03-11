import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  final String imageUrl, location, quantity, created;

  Food(
      {this.imageUrl = "null url",
      this.location = "null location",
      this.created = "null created",
      this.quantity = "null quantity"});

  factory Food.fromDocument(DocumentSnapshot document) {
    return Food.fromJson(document.data());
  }

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
        imageUrl: json['imageUrl'].toString(),
        location: json['location'].toString(),
        created: json['created'].toString(),
        quantity: json['quantity'].toString());
  }
}
