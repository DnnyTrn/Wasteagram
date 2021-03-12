import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Food {
  final String imageUrl, longitude, latitude, quantity, created;

  Food({
    this.imageUrl = "null url",
    this.longitude = "null longitude",
    this.latitude = "null latitude",
    this.created = "null created",
    this.quantity = "null quantity",
  });

  factory Food.fromDocument(DocumentSnapshot document) {
    return Food.fromJson(document.data());
  }

  factory Food.fromJson(Map<String, dynamic> json) {
    final _created =
        DateFormat("EEEE, MMM. d").format(json['created'].toDate());

    return Food(
        imageUrl: json['imageUrl'].toString(),
        longitude: json['longitude'].toString(),
        latitude: json['latitude'].toString(),
        created: _created.toString(),
        quantity: json['quantity'].toString());
  }

  Map<String, dynamic> toMap() {
    final int _quantity = int.parse(this.quantity);
    final DateTime _created = DateTime.parse(this.created);

    return {
      "imageUrl": this.imageUrl,
      "created": _created,
      "quantity": _quantity,
      "longitude": this.longitude,
      "latitude": this.latitude,
    };
  }
}
