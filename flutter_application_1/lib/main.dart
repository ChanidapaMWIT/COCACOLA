import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/MyHomePage.dart';
import 'package:flutter_application_1/pages/Page01.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    MyHomePage MHP = MyHomePage(title: "Home page");
    return MaterialApp(
      title: 'Dialog Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MHP,
    );
  }
}
