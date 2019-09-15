import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductListing extends StatefulWidget {
  final BuildContext context;
  final DocumentSnapshot documentSnapshot ;

  ProductListing({
    this.context,
    this.documentSnapshot
  });


  _ProductListingState createState() => _ProductListingState(context: context, documentSnapshot: documentSnapshot);
}

class _ProductListingState extends State<ProductListing> {

  final BuildContext context;
  final DocumentSnapshot documentSnapshot ;

  _ProductListingState({
    this.context,
    this.documentSnapshot
  });


  @override
  Widget build(BuildContext context) {
    return Container(
       child: InkWell(
         onTap: () => modalDialogUp(documentSnapshot),
                child: ListTile(
           leading: Icon(Icons.lightbulb_outline),
           title: Text(documentSnapshot['productName'],
           style: TextStyle(
             fontSize: 18,
           ),
           ),
           subtitle: Text('Quantity: ' + documentSnapshot['quantity'].toString()),
           trailing: Text("₹ " + documentSnapshot['sellPrice'].toString(),
           style: TextStyle(
             fontSize: 20
           ),
           ),
         ),
       ),
    );
  }


   modalDialogUp(DocumentSnapshot documentSnapshot) {
    print("Hello");
    Future.delayed(const Duration(milliseconds: 450), () {
      _showDialouge() ;
      _createSnackBar(documentSnapshot) ;

      
    });
  }

  _createSnackBar(DocumentSnapshot documentSnapshot) {
    final snackBar = SnackBar(
        backgroundColor: Colors.yellow,
        duration: const Duration(milliseconds: 820),
        content: Text(documentSnapshot['productName'] + " viewed",
          style: TextStyle(
            color: Colors.black
          ),
        ),
        );
      Scaffold.of(context).showSnackBar(snackBar) ;
  }

_showDialouge() {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("1234"),
      );
    }
    );
}


}

