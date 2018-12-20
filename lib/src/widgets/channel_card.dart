import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/channel.dart';

class ChannelCard extends StatelessWidget {
  final Channel data;
  final bool isLastChild;
  final onPressed;
  final bool hasFocus;

  ChannelCard(
      {@required this.data,
      @required this.onPressed,
      this.hasFocus,
      this.isLastChild = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: hasFocus ? Colors.grey[300] : Colors.transparent),
        margin: EdgeInsets.only(left: 15.0, right: isLastChild ? 15.0 : 0.0),
        child: FlatButton(
          padding: EdgeInsets.all(0.0),
          child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: .2),),
                    child: FadeInImage.assetNetwork(
                      height: 150.0,
                      width: 150.0,
                      fit: BoxFit.cover,
                      image: 'http://91.106.32.84/images/' + data.imageUrl,
                      placeholder: 'assets/placeholder.png',
                      
                    )),
                Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: Text(
                      data.title,
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.w300),
                    )),
              ])),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            List<String> recent = new List<String>.from(
                await prefs.get('recent') ?? List<String>());
            recent.add(data.id.toString());
            await prefs.setStringList('recent', recent);
            onPressed(data, context);
          },
        ));
  }
}
