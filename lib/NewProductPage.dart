import 'package:flutter/material.dart';
import 'package:price_list/BackEndLogics/CrudAction.dart';
import 'package:price_list/ProductListing.dart';

class NewProductPage extends StatefulWidget {
  NewProductPage({Key key}) : super(key: key);

  _NewProductPageState createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  String productName;
  String quantity;
  String costPrice;
  String sellPrice;

  CrudAction _crudAction = new CrudAction();

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
              onChanged: (value) => (this.productName = value),
              textInputAction: TextInputAction.next,
              maxLength: 15,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  focusColor: Colors.amber, hintText: "Enter product name"),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => (this.quantity = value),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  focusColor: Colors.amber, hintText: "Enter quantity"),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => (this.costPrice = value),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  focusColor: Colors.amber,
                  hintText: "Enter cost price (INR) "),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => (this.sellPrice = value),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
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
                  'sellPrice': this.sellPrice
                };

                _crudAction.addProductDetails(productDetails).then((result) {
                  dialoagTrigger(context);
                  Navigator.of(context).pop();

                  Future.delayed(const Duration(milliseconds: 500), () {
                    SnackBar snackbar = SnackBar(
                      content: Text("$this.productName added successfully"),
                      backgroundColor: Colors.amber,
                      duration: const Duration(milliseconds: 1000),
                    );
                    Scaffold.of(context).showSnackBar(snackbar);

                    setState(() {
                      ProductListing(context: context);
                    });
                  });
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
  }

  Future<bool> dialoagTrigger(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Job done'),
            titlePadding: const EdgeInsets.all(5),
            content: Text("$this.productName has been added succesfully"),
            contentPadding: const EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                child: Text('Alright'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
