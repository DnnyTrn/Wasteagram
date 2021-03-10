import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

class ShareLocationScreen extends StatefulWidget {
  @override
  _ShareLocationScreenState createState() => _ShareLocationScreenState();
}

class _ShareLocationScreenState extends State<ShareLocationScreen> {
  LocationData locationData;
  var locationService = Location();

  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  void retrieveLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }
    locationData = await locationService.getLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (locationData == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Latitude: ${locationData.latitude}',
              style: Theme.of(context).textTheme.headline4),
          Text('Longitude:  ${locationData.longitude}',
              style: Theme.of(context).textTheme.headline4),
          RaisedButton(
            child: Text('Share'),
            onPressed: () {
            },
          )
        ],
      ));
    }
  }
}
