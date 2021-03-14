import 'package:flutter/material.dart';
import 'package:wasteagram/models/food.dart';
import 'package:wasteagram/widgets/widgets.dart';
import 'package:wasteagram/style.dart';

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
              Text('${dateFormat(food.created)}', style: Styles.titleStyle),
              Semantics(
                  onTapHint: "image of the post",
                  image: true,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                        height: 250, child: Image.network('${food.imageUrl}')),
                  )),
              Text('Items: ${food.quantity}', style: Styles.itemStyle),
              SizedBox(height: 10),
              Semantics(
                  onTapHint: "Longitude and Latiude of when the post was saved",
                  child: Text('(${food.longitude} ${food.latitude})',
                      style: Styles.bodyStyle)),
            ],
          ),
        ),
      ),
    );
  }
}
