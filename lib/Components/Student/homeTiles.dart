import 'package:flutter/material.dart';

class HomeComponents {
  gridItem(image,title,color) {
    return Expanded(
        child: InkWell(
      onTap: () {},
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/$image.png",
              height: 55,
              width: 55,
            ),
            SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(fontSize: 19, color: Colors.white),
            )
          ],
        ),
        color: color,
      ),
    ));
  }
}
