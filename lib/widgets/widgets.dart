import 'package:flutter/material.dart';
import 'package:wasteagram/screens/new_post_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
// import 'package:wasteagram/screens/share_location_screen.dart';

// Tapping on the large button enables an employee to capture a photo, or select a photo from the device's photo gallery.
class GetPhoto extends StatelessWidget {
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        pickImage(context);
      },
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
  File image;
  ShareImageButton({Key key, @required this.imagePath}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('Share'),
      onPressed: _uploadImage,
    );
  }

  void _uploadImage() async {
    try {
      image = File(imagePath);
      Reference uploadReference =
          FirebaseStorage.instance.ref(basename(imagePath));
      await uploadReference.putFile(image);

      String downloadUrl = await uploadReference.getDownloadURL();
    } on FirebaseException catch (error) {
      print(error);
    }
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
