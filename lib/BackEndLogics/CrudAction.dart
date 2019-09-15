import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CrudAction {
  
  Future<void> addProductDetails(productDetails) async {
    Firestore.instance.collection('products').add(productDetails).catchError((e) => print(e));
  }


}