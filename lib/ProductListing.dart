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
         onTap: () => modalDialogUp(),
                child: ListTile(
           leading: Icon(Icons.lightbulb_outline),
           title: Text(documentSnapshot['productName'],
           style: TextStyle(
             fontSize: 18,
           ),
           ),
           subtitle: Text('Quantity: ' + documentSnapshot['quantity'].toString()),
           trailing: Text("\$ " + documentSnapshot['sellPrice'].toString(),
           style: TextStyle(
             fontSize: 20
           ),
           ),
         ),
       ),
    );
  }


   modalDialogUp() {
    print("Hello");
    Future.delayed(const Duration(milliseconds: 450), () {
      final snackBar = SnackBar(
        backgroundColor: Colors.yellow,
        duration: const Duration(milliseconds: 820),
        content: Text("Yay!, A SnackBar",
          style: TextStyle(
            color: Colors.black
          ),
        ),
        );
      Scaffold.of(context).showSnackBar(snackBar) ;
    });
  }



}

