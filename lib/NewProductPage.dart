import 'dart:async';

import 'package:flutter/material.dart';
import 'package:price_list/BackEndLogics/CrudAction.dart';

class NewProductPage extends StatefulWidget {
  NewProductPage({Key key}) : super(key: key);

  _NewProductPageState createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  String productName;
  String quantity;
  String costPrice;
  String sellPrice;
  var date = DateTime.now();
  // var dateTime = date.toString().substring(0, 11).replaceAll('-',' ') ;

  final _text = TextEditingController();
  bool _validate = false;

  CrudAction _crudAction = new CrudAction();

  @override
  void dispose() {
    // TODO: implement dispose
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: _newProductPage(),
    );
  }

  _newProductPage() {
    return Container(
      decoration: BoxDecoration(
          // color: Colors.white
          ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            TextField(
              controller: _text,
              onChanged: (value) => ((this.productName = value)),
              textInputAction: TextInputAction.next,
              maxLength: 30,
              autofocus: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  errorText: _validate ? " value can\'t be empty" : null,
                  focusColor: Colors.amber,
                  hintText: "Enter product name"),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              // controller: _text,
              onChanged: (value) => ((this.quantity = value)),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  errorText: _validate ? " value can\'t be empty" : null,
                  focusColor: Colors.amber,
                  hintText: "Enter quantity"),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              // controller: _text,
              onChanged: (value) => ((this.costPrice = value)),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  errorText: _validate ? " value can\'t be empty" : null,
                  focusColor: Colors.amber,
                  hintText: "Enter cost price (INR) "),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              // controller: _text,
              onChanged: (value) => ((this.sellPrice = value)),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  errorText: _validate ? " value can\'t be empty" : null,
                  focusColor: Colors.yellow,
                  hintText: "Enter sell price (INR) "),
            ),
            SizedBox(
              height: 40,
            ),
            FlatButton(
              color: Colors.amber,
              child: Text(
                "SAVE",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Map<String, String> productDetails = {
                  'productName': this.productName,
                  'quantity': this.quantity,
                  'costPrice': this.costPrice,
                  'sellPrice': this.sellPrice,
                  'updatedAt':
                      date.toString().substring(0, 11).replaceAll('-', ' ')
                };

                _crudAction.addProductDetails(productDetails).then((result) {
                    Navigator.of(context).pop();
                    dialoagTrigger(context);
                  }).catchError((e) => print(e));
                  
                  clearDefaults();

              },
            )
          ],
        ),
      ),
    );
  }

  clearDefaults() {
    this.productName = "";
    this.quantity = "";
    this.costPrice = "";
    this.sellPrice = "";
    this.date = null;
  }

  Future<bool> dialoagTrigger(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Notice", 
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
            ),
            titlePadding: const EdgeInsets.all(16),
            content: Text("The item is successfully added."),
            contentPadding: const EdgeInsets.all(16),
            actions: <Widget>[
              FlatButton(
                child: Text('Alright'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
