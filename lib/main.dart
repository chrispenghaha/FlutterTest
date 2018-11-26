import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle descTextStyle = new TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w800,
      fontFamily: 'Roboto',
      letterSpacing: 0.5,
      fontSize: 13.0,
      height: 2.0,
    );
    var iconList = DefaultTextStyle.merge(
        child: new Container(
          padding: new EdgeInsets.all(5.0),
          child: new Row(
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new Icon(Icons.kitchen, color: Colors.green[500]),
                  new Text('食材:'),
                  new Text('30分钟'),
                ],
              ),
              new Column(
                children: <Widget>[
                  new Icon(Icons.timer, color: Colors.green[500]),
                  new Text('烹饪:'),
                  new Text('5分钟'),
                ],
              ),
              new Column(
                children: <Widget>[
                  new Icon(Icons.restaurant, color: Colors.green[500]),
                  new Text('品尝:'),
                  new Text('25分钟'),
                ],
              )
            ],
          ),
        ),
        style: descTextStyle);
    return new MaterialApp(
      title: "测试",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("布局测试"),
        ),
        body: iconList,
      ),
    );
  }
}

void main() {
  runApp(new MyApp());
}
