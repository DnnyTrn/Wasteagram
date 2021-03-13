import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  String imageUrl, longitude, latitude;
  DateTime created;
  int quantity;

  Food({
    this.imageUrl = "null url",
    this.longitude = "null longitude",
    this.latitude = "null latitude",
    this.quantity = -1,
    this.created,
  });

  factory Food.fromDocument(DocumentSnapshot document) {
    return Food.fromMap(document.data());
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    var _created = map['created'];
    // convert Firestore Timestamp to expected DateTime
    if (map['created'] is Timestamp) _created = _created.toDate();

    return Food(
        imageUrl: map['imageUrl'].toString(),
        longitude: map['longitude'].toString(),
        latitude: map['latitude'].toString(),
        created: _created,
        quantity: map['quantity']);
  }

  Map<String, dynamic> toMap() {
    return {
      "imageUrl": this.imageUrl,
      "created": this.created,
      "quantity": this.quantity,
      "longitude": this.longitude,
      "latitude": this.latitude,
    };
  }
}
