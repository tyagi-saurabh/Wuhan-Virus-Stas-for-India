import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final Widget icon;
  final Widget title;
  final Widget number;
  MyCard({this.title, this.icon, this.number});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[title, icon, number],
          ),
        ),
      ),
    );
  }
}
