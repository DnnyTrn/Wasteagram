import 'package:flutter/material.dart';
import 'package:wasteagram/screens/detail_screen.dart';
import 'package:wasteagram/screens/list_screen.dart';
import 'package:wasteagram/screens/new_post_screen.dart';
import 'package:wasteagram/widgets/widgets.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static final routes = {
    '/': (context) => ListScreen(),
    DetailScreen.routeName: (context) => DetailScreen(),
    NewPostScreen.routeName: (context) => NewPostScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wasteagram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: routes,
    );
  }
}

class LoadingScaffold extends StatefulWidget {
  @override
  LoadingScaffoldState createState() => LoadingScaffoldState();
}

class LoadingScaffoldState extends State<LoadingScaffold> {
  int documentCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Wasteagram - $documentCount')),
      body: LoadingWidget(),
      floatingActionButton: Semantics(
        child: GetPhoto(),
        button: true,
        enabled: true,
        onTapHint: 'this button opens the device\'s image gallery',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
