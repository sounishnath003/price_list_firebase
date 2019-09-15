import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductListing extends StatefulWidget {
  final BuildContext context;
  final DocumentSnapshot documentSnapshot;

  ProductListing({this.context, this.documentSnapshot});

  _ProductListingState createState() => _ProductListingState(
      context: context, documentSnapshot: documentSnapshot);
}

class _ProductListingState extends State<ProductListing> {
  final BuildContext context;
  final DocumentSnapshot documentSnapshot;

  _ProductListingState({this.context, this.documentSnapshot});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () => modalDialogUp(documentSnapshot),
        child: ListTile(
          leading: Icon(Icons.lightbulb_outline),
          title: Text(
            documentSnapshot['productName'],
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          subtitle:
              Text('Quantity: ' + documentSnapshot['quantity'].toString()),
          trailing: Text(
            "₹ " + documentSnapshot['sellPrice'].toString(),
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  modalDialogUp(DocumentSnapshot documentSnapshot) {
    print("Hello");
    Future.delayed(const Duration(milliseconds: 450), () {
      setState(() {
        _showDialouge(documentSnapshot);
      });
    });
  }

  _createSnackBar(DocumentSnapshot documentSnapshot) {
    final snackBar = SnackBar(
      backgroundColor: Colors.yellow,
      duration: const Duration(milliseconds: 820),
      content: Text(
        documentSnapshot['productName'] + " viewed",
        style: TextStyle(color: Colors.black),
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  _showDialouge(DocumentSnapshot documentSnapshot) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(
              documentSnapshot['productName'],
              style: TextStyle(
                // backgroundColor: Colors.amberAccent,
                fontSize: 22,  
              ),
              textAlign: TextAlign.center,
            ),
            titlePadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    _rowWiseDetails("Quantity", documentSnapshot['quantity'].toString()),
                    _rowWiseDetails("Cost Price", documentSnapshot['costPrice'].toString()),
                    _rowWiseDetails("Sell Price", documentSnapshot['sellPrice'].toString()),
                  ],
                ),
              )
            ],
          );
        });
  }

  _rowWiseDetails(String string, String details) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                "$string",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                    ),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                "$details",
                style: TextStyle(
                  fontSize: 22,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
