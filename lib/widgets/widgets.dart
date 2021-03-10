import 'package:flutter/material.dart';

// import 'package:wasteagram/screens/share_location_screen.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

class ShareImageButton extends StatelessWidget {
  final Function shareImage;
  const ShareImageButton({Key key, @required this.shareImage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('Share'),
      onPressed: () => shareImage(),
    );
  }
}

class GetImageButton extends StatelessWidget {
  final Function pickImage;
  const GetImageButton({Key key, @required this.pickImage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('Select Image'),
        onPressed: () => pickImage(),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}

class NullWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(child: Column(children: [Text('null widget')])));
  }
}

class MainTabController extends StatelessWidget {
  final int length, initialIndex;
  final Widget scaffold;
  final List<Widget> tabs, screens;

  const MainTabController({
    Key key,
    this.length = 0,
    this.initialIndex = 0,
    this.scaffold,
    List<Widget> tabs = const <Widget>[],
    List<Widget> screens = const <Widget>[],
  })  : this.screens = screens,
        this.tabs = tabs,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: this.initialIndex,
      length: this.length,
      child: this.scaffold,
    );
  }
}
