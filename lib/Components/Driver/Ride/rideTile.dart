import 'package:flutter/material.dart';

class RideTile extends StatelessWidget {
  final rideName;
  final helperName;
  final rideId;
  final bool live;
  RideTile({this.helperName, this.live, this.rideId, this.rideName});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Material(
          elevation: 3,
          child: Container(
            height: 82.5,
            child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    rideName,
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
                subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5.5),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.directions_bus,
                              color: Colors.orange,
                              size: 12,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              live == true ? "Started" : "Not Started Yet",
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              color: Colors.orange,
                              size: 12,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                                'Helper Name: ' +
                                    helperName,
                                style: TextStyle(color: Colors.black))
                          ],
                        )
                      ],
                    ))),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }
}
