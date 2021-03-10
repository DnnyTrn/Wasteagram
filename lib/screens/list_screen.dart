import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/food.dart';
import 'package:wasteagram/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ListScreen extends StatefulWidget {
  State createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    CollectionReference firestore =
        FirebaseFirestore.instance.collection('food');
    return StreamBuilder(
        stream: firestore.snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return LoadingWidget();
            case ConnectionState.active:
            case ConnectionState.done:
              return ListViewBuilder(snapshot: snapshot);
          }
          if (snapshot.hasError) {
            ErrorWidget.builder = (FlutterErrorDetails details) {
              return ErrorWidget(details.exception);
            };
          }
          return LoadingWidget();
        });
  }
}

class ListViewBuilder extends StatelessWidget {
  final snapshot;
  ListViewBuilder({@required this.snapshot});
  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData &&
        snapshot.data.docs != null &&
        snapshot.data.docs.length > 0) {
      return new ListView(
          children: snapshot.data.docs.map<Widget>((DocumentSnapshot document) {
        return new ListTile(
          title: new Text(document.data()['name']),
          subtitle: new Text(document.data()['weight'].toString()),
        );
      }).toList());
    }
    return LoadingWidget();
  }
}

//  try {
//       await db.insert(
//         TABLE_NAME,
//         journal.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace,
//       );
//     } catch (err) {
//       throw (err);
//     }
