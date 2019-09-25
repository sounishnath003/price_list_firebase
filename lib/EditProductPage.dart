import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:price_list/BackEndLogics/CrudAction.dart';
import 'package:price_list/ProductListing.dart';

class EditProductPage extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  EditProductPage({Key key, this.documentSnapshot}) : super(key: key);

  _EditProductPageState createState() =>
      _EditProductPageState(documentSnapshot);
}

class _EditProductPageState extends State<EditProductPage> {
  DocumentSnapshot documentSnapshot;

  CrudAction crudAction = new CrudAction();

  String productName;
  String quantity;
  String costPrice;
  String sellPrice;

  @required
  _EditProductPageState(this.documentSnapshot);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Product"),
      ),
      body: _updateProductPage(documentSnapshot),
    );
  }

  _updateProductPage(DocumentSnapshot documentSnapshot) {
    
    initializeValuesWithPrevious();

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
            Text("Change Name"),
            TextField(
              onChanged: (value) => ((this.productName = value)),
              textInputAction: TextInputAction.next,
              maxLength: 30,
              autofocus: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  focusColor: Colors.amber,
                  hintText: "Name: " + documentSnapshot['productName']),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Change Quantity"),
            TextField(
              // controller: _text,
              onChanged: (value) => ((this.quantity = value)),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  focusColor: Colors.amber,
                  hintText: "Quantity: " + documentSnapshot['quantity']),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Change Cost Price"),
            TextField(
              // controller: _text,
              onChanged: (value) => ((this.costPrice = value)),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  focusColor: Colors.amber,
                  hintText: "Cost: " + documentSnapshot['costPrice']),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Change Sell Price"),
            TextField(
              // controller: _text,
              onChanged: (value) => ((this.sellPrice = value)),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  focusColor: Colors.yellow,
                  hintText: "Sell: " + documentSnapshot['sellPrice']),
            ),
            SizedBox(
              height: 40,
            ),
            FlatButton(
              color: Colors.amber,
              child: Text(
                "Update Details",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Map<String, String> editedProductDetails = {
                  'productName': this.productName,
                  'quantity': this.quantity,
                  'costPrice': this.costPrice,
                  'costPrice': this.costPrice,
                  'sellPrice': this.sellPrice,
                };

                print(documentSnapshot.documentID) ;

                crudAction.updateProductDetails(documentSnapshot.documentID, editedProductDetails) ;
                
                Navigator.of(context).pop();
                Navigator.of(context).pop();

              },
            )
          ],
        ),
      ),
    );
  }

  initializeValuesWithPrevious() {
    this.productName = documentSnapshot['productName'];
    this.quantity = documentSnapshot['quantity'];
    this.costPrice = documentSnapshot['costPrice'];
    this.sellPrice = documentSnapshot['sellPrice'];
  }
}
