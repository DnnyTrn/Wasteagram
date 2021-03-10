import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  final String name, height;
  final String mass;
  final String created;
  DocumentReference reference;

  Food(
      {this.name = 'null name',
      this.height = 'null ht',
      this.mass = 'null mass',
      this.created,
      this.reference});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
        name: json['userId'].toString(),
        height: json['id'].toString(),
        mass: json['title'].toString(),
        created: json['completed'].toString());
  }
}
