import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:wasteagram/screens/detail_screen.dart';
import 'package:wasteagram/screens/list_screen.dart';
import 'package:wasteagram/widgets/keyboard.dart';
import 'screens/new_post_screen.dart';
import 'screens/share_location_screen.dart';
import 'widgets/widgets.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static final routes = {
    '/': (context) => HomeScaffold(),
    DetailScreen.routeName: (context) => DetailScreen(),
    ListScreen.routeName: (context) => ListScreen(),
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

class HomeScaffold extends StatefulWidget {
  @override
  _HomeScaffoldState createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: ListScreen(),
      // body: NewPostScreen(),
      floatingActionButton: GetPhoto(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
