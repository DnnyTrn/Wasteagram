import 'package:flutter/material.dart';
import 'package:wasteagram/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';

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
