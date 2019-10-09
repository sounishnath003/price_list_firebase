import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_web/firebase.dart' as fb ;
import 'package:price_list/MyHomePage.dart';
import 'package:price_list/NewProductPage.dart';

void main() async {
   
   assert(() {
     fb.initializeApp(
      apiKey: "AIzaSyAM32VWRlJp3KZiGbaykhP-D-QxqNes4U8",
      authDomain: "pricelist-85b49.firebaseapp.com",
      databaseURL: "https://pricelist-85b49.firebaseio.com",
      projectId: "pricelist-85b49",
      storageBucket: "pricelist-85b49.appspot.com",
      messagingSenderId: "5084648559",
      //appId: "1:5084648559:web:52346a581b078e6036699a"
     );
     return true ;
   }());

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
