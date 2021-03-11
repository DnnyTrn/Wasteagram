import 'package:flutter/material.dart';
import 'package:wasteagram/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'dart:io';

class DetailScreen extends StatefulWidget {
  State createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  File image;
  final imagePicker = ImagePicker();

  void pickImage() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    image = File(pickedFile.path);

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref(pickedFile.path)
          .putFile(image);
    } on firebase_core.FirebaseException catch (error) {
      print(error);
    }

    // final downloadurl = firebaseStorageInstance.ref().getDownloadURL();
    setState(() {});
  }

  void shareImage() async {
    await Share.shareFiles([image.path]);
    // Share.share('check out my website https://example.com');
  }

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return GetImageButton(pickImage: pickImage);
    } else {
      return Center(
        child: Column(
          children: [
            Center(child: Image.file(image)),
            ShareImageButton(shareImage: shareImage),
          ],
        ),
      );
    }
  }
}
