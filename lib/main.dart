import 'package:flutter/material.dart';
import 'package:price_list/MyHomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Price List',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange
      ),
      home: MyHomePage(title: 'My Price List'),
    );
  }
}
