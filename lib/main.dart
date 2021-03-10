import 'package:flutter/material.dart';
import 'package:wasteagram/screens/list_screen.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const List<Widget> tabs = [
    Icon(Icons.face_retouching_natural),
    Icon(Icons.text_snippet_outlined),
    Icon(Icons.casino_outlined)
  ];

  static final List<Widget> screens = [
    ListScreen(),
    ShareLocationScreen(),
    Text('3rd screen')
  ];
  @override
  Widget build(BuildContext context) {
    return MainTabController(
      length: tabs.length,
      scaffold: Scaffold(
        appBar: AppBar(bottom: TabBar(tabs: tabs)),
        body: TabBarView(
          children: screens,
        ),
      ),
    );
  }
}
