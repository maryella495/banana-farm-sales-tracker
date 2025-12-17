import 'package:flutter/material.dart';

AppBar appBar() {
  return AppBar(
    leading: Container(margin: EdgeInsets.all(10), child: Icon(Icons.menu)),
    centerTitle: true,
    title: Text('Dashboard'),
    actions: [
      Container(margin: EdgeInsets.all(10), child: Icon(Icons.notifications)),
    ],
  );
}
