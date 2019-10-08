import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:price_list/MyHomePage.dart';
import 'package:price_list/NewProductPage.dart';

void main() async {
   

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
   runApp(MyApp()) ;
   }

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
      home:  MyHomePage(title: 'My Price List') //NewProductPage()

    );
  }
}
