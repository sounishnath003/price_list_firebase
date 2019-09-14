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
        fontFamily: "Product",
        primaryColor: Colors.white,
        primarySwatch: Colors.amber,
        iconTheme: IconThemeData(color: Colors.black)
      ),
      home: MyHomePage(title: 'My Price List'),
    );
  }
}
