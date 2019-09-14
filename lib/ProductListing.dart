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
       child: ListTile(
         title: Text(documentSnapshot['productName']),
         subtitle: Text(documentSnapshot['quantity'].toString()),
       ),
    );
  }
}