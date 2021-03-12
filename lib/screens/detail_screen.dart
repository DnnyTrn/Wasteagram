import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/widgets/widgets.dart';
import 'package:share/share.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'dart:io';

class DetailScreen extends StatefulWidget {
  static String routeName = 'DetailScreen';
  State createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text('details'),
    );
  }
  // File image;

  // void pickImage() async {
  //   PickedFile pickedFile =
  //       await ImagePicker().getImage(source: ImageSource.gallery);
  //   if (pickedFile == null) return; //user canceled image pick
  //   try {
  //     image = File(pickedFile.path);
  //     Reference uploadReference =
  //         FirebaseStorage.instance.ref(basename(image.path));
  //     await uploadReference.putFile(image);
  //     String downloadUrl = await uploadReference.getDownloadURL();
  //   } on FirebaseException catch (error) {
  //     print(error);
  //   }
  //   setState(() {});
  // }

  // void shareImage() async {
  //   await Share.shareFiles([image.path]);
  //   // Share.share('check out my website https://example.com');
  // }

  // @override
  // Widget build(BuildContext context) {
  //   if (image == null) {
  //     return GetImageButton(pickImage: pickImage);
  //   } else {
  //     return Center(
  //       child: Column(
  //         children: [
  //           Center(child: Image.file(image)),
  //           ShareImageButton(shareImage: shareImage),
  //         ],
  //       ),
  //     );
  //   }
  // }
}
