import 'package:flutter/material.dart';
import 'package:flutter_app/page/HomePage.dart';
import 'widget/CustomTabBarWidget.dart';

void main() {
  _renderTab(icon, text) {
    return new Tab(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[new Icon(icon, size: 16.0), new Text(text)],
      ),
    );
  }

  List<Widget> tabs = [
    _renderTab(Icons.my_location, "首页"),
  ];

  runApp(
    new MaterialApp(
        home: new CustomTabBarWidget(
      tabItems: tabs,
      type: CustomTabBarWidget.BOTTOM_TAB,
      tabViews: [
        new HomePage(),
      ],
      drawer: new Drawer(
        child: new Container(
          child: new Material(),
        ),
      ),
    )),
  );
}
