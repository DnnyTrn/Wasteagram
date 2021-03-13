import 'package:flutter/material.dart';
import 'package:wasteagram/app.dart';
import '../models/food.dart';
import 'package:wasteagram/widgets/widgets.dart';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'detail_screen.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/style.dart';

class ListScreen extends StatefulWidget {
  static String routeName = "ListScreen";
  State createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    Query firestore = FirebaseFirestore.instance
        .collection('food')
        .orderBy("created", descending: true);
    return StreamBuilder(
        stream: firestore.snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return LoadingScaffold();
            case ConnectionState.active:
            case ConnectionState.done:
              return ListViewBuilder(snapshot: snapshot);
          }
          if (snapshot.hasError) {
            ErrorWidget.builder = (FlutterErrorDetails details) {
              return ErrorWidget(details.exception);
            };
          }
          return LoadingScaffold();
        });
  }
}

class ListViewBuilder extends StatelessWidget {
  final snapshot;
  ListViewBuilder({@required this.snapshot});
  @override
  Widget build(BuildContext context) {
    int documentCount;
    if (snapshot.hasData &&
        snapshot.data.docs != null &&
        snapshot.data.docs.length > 0) {
      documentCount = snapshot.data.docs.length;
      return Scaffold(
        appBar: AppBar(title: Text('Wasteagram - $documentCount')),
        body: new ListView(
            children:
                snapshot.data.docs.map<Widget>((DocumentSnapshot document) {
          final food = Food.fromMap(document.data());
          return new ListTile(
            onTap: () => Navigator.pushNamed(context, DetailScreen.routeName,
                arguments: food),
            title: new Text('${dateFormat(food.created)}'),
            trailing: new Text('${food.quantity}'),
          );
        }).toList()),
        floatingActionButton: GetPhoto(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    }
    return LoadingScaffold();
  }
}
