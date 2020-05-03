import 'dart:math';

import 'package:flutter/material.dart';

import 'city_image.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(
            children: <Widget>[
              CityImage("assets/shape_34.png", Point(67.0, 41.0)),
              CityImage("assets/shape_36.png", Point(157.5, 93.5)),

            ],

          )
      ),
    );
  }
}
