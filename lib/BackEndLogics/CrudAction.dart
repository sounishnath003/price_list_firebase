import 'package:cloud_firestore/cloud_firestore.dart';


class CrudAction {
  
  // addNewProduct methods()
  Future<void> addProductDetails(productDetails) async {
    // Firestore.instance.collection('products').add(productDetails).catchError((e) => print(e));

    // works well with streamBuilder to update data efficently
    Firestore.instance.runTransaction((Transaction crudTransaction) async {
      CollectionReference reference = Firestore.instance.collection('products') ;
      reference.add(productDetails) ;
    }) ;

  }

  // updateProductDetails methods() 
  Future<void> updateProductDetails(selectedDoc, newValues) async {
    Firestore.instance.collection('products').document(selectedDoc).updateData(newValues).catchError((e) => print(e)) ;
  }

  // deleteProductID methods()
  Future<void> deleteProduct(docID) async {
    Firestore.instance.collection('products').document(docID).delete().catchError((e) => print(e)) ;
  }

   getAllData() async {
    return await Firestore.instance.collection('products').getDocuments().catchError((e) => print(e)) ;
  }

}