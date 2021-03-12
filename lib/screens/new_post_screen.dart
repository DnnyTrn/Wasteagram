import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:wasteagram/widgets/widgets.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class NewPostScreen extends StatefulWidget {
  static const String routeName = 'NewPostScreen';
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  GlobalKey<FormState> formKey;
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
  }

  Widget build(BuildContext context) {
    final imagePath = ModalRoute.of(context).settings.arguments;
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
      floatingActionButton: ShareImageButton(imagePath: imagePath),
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
            child: TextFormField(
              focusNode: _nodeText1,
              decoration: InputDecoration(
                  hintText: "Number of items", border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
          ),
        ]),
      ),
      // body: Form(
      //     key: formKey,
      //     child: Column(
      //       children: [
      //         Image.network(imageUrl),
      //       ],
      //     )),
    );
  }

  List<Widget> formFields(BuildContext context) {
    return [TextFormField()];
  }

  // Navigator.of(context).pop();
}
