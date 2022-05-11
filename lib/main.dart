import 'package:flutter/material.dart';
import 'package:news/home.dart';

void main() => runApp(myApp());

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "News App",
      home: Home(),
    );
  }
}
