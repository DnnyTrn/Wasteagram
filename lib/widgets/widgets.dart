import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:wasteagram/screens/new_post_screen.dart';
import 'package:image_picker/image_picker.dart';

AppBar wasteagramAppBar() => AppBar(title: Text('Wasteagram'));

// Tapping on the large button enables an employee to capture a photo, or select a photo from the device's photo gallery.
class GetPhoto extends StatelessWidget {
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => pickImage(context),
      child: Icon(Icons.photo_camera),
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
  final Function buttonFunction;
  ShareImageButton({
    this.buttonFunction,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      onTapHint:
          "this button saves and uploads the post. After successful save, screen will return back to home screen",
      enabled: true,
      button: true,
      child: ElevatedButton(
        child: Icon(Icons.cloud_upload, size: 60),
        onPressed: buttonFunction,
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20)),
      ),
    );
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

class LoadingWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Semantics(
        image: false,
        onTapHint:
            "content is currently loading or is unavailable at this time",
        button: false,
        child: Center(child: CircularProgressIndicator()));
  }
}
