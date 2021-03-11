import 'package:flutter/material.dart';
import 'package:wasteagram/screens/detail_screen.dart';
import 'package:wasteagram/screens/list_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wasteagram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => HomeScaffold(),
        NewPostScreen.routeName: (context) => NewPostScreen(),
      },
    );
  }
}

class HomeScaffold extends StatefulWidget {
  @override
  _HomeScaffoldState createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  static const List<Widget> tabs = [
    Icon(Icons.face_retouching_natural),
    Icon(Icons.text_snippet_outlined),
    Icon(Icons.casino_outlined)
  ];

  static final List<Widget> screens = [
    DetailScreen(),
    ListScreen(),
    ShareLocationScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return MainTabController(
      length: tabs.length,
      scaffold: Scaffold(
        appBar: AppBar(bottom: TabBar(tabs: tabs)),
        body: TabBarView(children: screens),
        floatingActionButton: AddToDatabaseButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
