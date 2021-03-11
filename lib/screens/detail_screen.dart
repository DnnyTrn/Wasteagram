import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DetailScreen extends StatefulWidget {
  State createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  File image;

  void pickImage() async {
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    image = File(pickedFile.path);

    try {
      await FirebaseStorage.instance.ref(basename(image.path)).putFile(image);
      // Reference storageReference =
      //     FirebaseStorage.instance.ref().child('test.jpg');
      // await storageReference.putFile(image);
    } on FirebaseException catch (error) {
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
