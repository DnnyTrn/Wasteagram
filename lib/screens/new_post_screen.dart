import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:wasteagram/models/food.dart';
import 'package:wasteagram/widgets/widgets.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class NewPostScreen extends StatefulWidget {
  static const String routeName = 'NewPostScreen';
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  GlobalKey<FormState> formKey;
  String imagePath;
  Food sendFood;
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    sendFood = Food();
  }

  Widget build(BuildContext context) {
    imagePath = ModalRoute.of(context).settings.arguments;
    assert(imagePath != null);

    final FocusNode _nodeText1 = FocusNode();
    KeyboardActionsConfig _buildConfig(BuildContext context) {
      return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        keyboardBarColor: Colors.grey[200],
        nextFocus: true,
        actions: [KeyboardActionsItem(focusNode: _nodeText1)],
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: ShareImageButton(buttonFunction: uploadImage),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(),
      body: KeyboardActions(
        config: _buildConfig(context),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(height: 225, child: Image.file(File(imagePath))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: TextFormField(
                focusNode: _nodeText1,
                validator: validateField,
                onSaved: (value) {
                  sendFood.quantity = int.parse(value);
                  Navigator.of(context).pop();
                },
                decoration: InputDecoration(
                    hintText: "Number of items", border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void uploadImage() async {
    // validate form
    final formState = formKey.currentState;
    if (formState.validate() == false) {
      return;
    }
    formKey.currentState.save();

    try {
      // send image to fire storage
      Reference uploadReference =
          FirebaseStorage.instance.ref(DateTime.now().toString());
      await uploadReference.putFile(File(imagePath));

      // preparing document to send to firestore
      sendFood.created = DateTime.now();
      sendFood.imageUrl = await uploadReference.getDownloadURL();
      LocationData _currentLocation = await retrieveLocation();
      assert(_currentLocation != null);
      sendFood.longitude = _currentLocation.longitude.toString();
      sendFood.latitude = _currentLocation.latitude.toString();

      FirebaseFirestore.instance.collection('food').add(sendFood.toMap());
    } on FirebaseException catch (error) {
      print(error);
    }
  }

  String validateField(value) =>
      value.isEmpty ? 'This field cannot be blank.' : null;
}
