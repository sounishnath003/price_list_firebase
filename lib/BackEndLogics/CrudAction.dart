import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CrudAction {
  
  // addNewProduct methods()
  Future<void> addProductDetails(productDetails) async {
    Firestore.instance.collection('products').add(productDetails).catchError((e) => print(e));
  }

  // updateProductDetails methods() 
  Future<void> updateProductDetails(selectedDoc, newValues) {
    Firestore.instance.collection('products').document(selectedDoc).updateData(newValues).catchError((e) => print(e)) ;
  }

  // deleteProductID methods()
  Future<void> deleteProduct(docID) async {
    Firestore.instance.collection('products')..document(docID).delete().catchError((e) => print(e)) ;
  }

}