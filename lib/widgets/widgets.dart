import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:wasteagram/models/food.dart';
import 'package:wasteagram/screens/new_post_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';

AppBar wasteagramAppBar() => AppBar(title: Text('Wasteagram'));

// Tapping on the large button enables an employee to capture a photo, or select a photo from the device's photo gallery.
class GetPhoto extends StatelessWidget {
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => pickImage(context),
      child: Icon(Icons.add),
    );
  }

  void pickImage(BuildContext context) async {
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile == null) return; //user canceled image pick

    Navigator.pushNamed(context, NewPostScreen.routeName,
        arguments: pickedFile.path);
  }
}

class ShareImageButton extends StatelessWidget {
  final String imagePath;

  ShareImageButton({Key key, @required this.imagePath}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Icon(Icons.cloud_upload, size: 60),
      onPressed: _uploadImage,
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20)),
    );
  }

  void _uploadImage() async {
    try {
      File image = File(imagePath);
      Reference uploadReference =
          FirebaseStorage.instance.ref(DateTime.now().toString());
      await uploadReference.putFile(image);

      String downloadUrl = await uploadReference.getDownloadURL();
      LocationData _currentLocation = await retrieveLocation();

      Food newFoodToFire = Food(
        imageUrl: downloadUrl,
        created: DateTime.now().toIso8601String(),
        quantity: "0",
        longitude: _currentLocation.longitude.toString(),
        latitude: _currentLocation.latitude.toString(),
      );
      
      FirebaseFirestore.instance.collection('food').add(newFoodToFire.toMap());
    } on FirebaseException catch (error) {
      print(error);
    }
  }
}

Future<LocationData> retrieveLocation() async {
  LocationData locationData;
  var locationService = Location();
  try {
    var _serviceEnabled = await locationService.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locationService.requestService();
      if (!_serviceEnabled) {
        print('Failed to enable service. Returning.');
        return null;
      }
    }

    var _permissionGranted = await locationService.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await locationService.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('Location service permission not granted. Returning.');
        return null;
      }
    }
    locationData = await locationService.getLocation();
  } on PlatformException catch (e) {
    print('Error: ${e.toString()}, code: ${e.code}');
    locationData = null;
  }
  locationData = await locationService.getLocation();

  return locationData;
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
