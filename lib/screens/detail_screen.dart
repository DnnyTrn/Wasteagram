import 'package:flutter/material.dart';
import 'package:wasteagram/models/food.dart';
import 'package:wasteagram/widgets/widgets.dart';

class DetailScreen extends StatefulWidget {
  static String routeName = 'DetailScreen';
  State createState() => _DetailScreenState();
}

// The Detail Screen should display the post's date, photo, number of wasted items,
// and the latitude and longitude that was recorded as part of the post.
class _DetailScreenState extends State<DetailScreen> {
  Widget build(BuildContext context) {
    final Food food = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: wasteagramAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('${food.created}'),
              SizedBox(height: 250, child: Image.network('${food.imageUrl}')),
              Text('Items: ${food.quantity}'),
              Text('(${food.longitude} ${food.latitude})'),
            ],
          ),
        ),
      ),
    );
  }
}
