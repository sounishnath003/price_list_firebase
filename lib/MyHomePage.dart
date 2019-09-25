import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:price_list/BackEndLogics/CrudAction.dart';
import 'package:price_list/BackEndLogics/Microservices/GeneratingPdf.dart';
import 'package:price_list/NewProductPage.dart';
import 'package:price_list/PdfViewerPage.dart';
import 'package:price_list/ProductListing.dart';
import 'package:pdf/widgets.dart' as pdfLib;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

QuerySnapshot allProducts;
QuerySnapshot productsForPdfListing;

class _MyHomePageState extends State<MyHomePage> {
  CrudAction crudAction = new CrudAction();

  // for querying the firestore objects
  Future<QuerySnapshot> querySnapshotProducts;
  QuerySnapshot documentSnapshot;

  Future<void> refreshLists() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      querySnapshotProducts =
          Firestore.instance.collection('products').getDocuments();
      querySnapshotProducts.then((res) => {documentSnapshot = res});
    });
  }

  @override
  void initState() {
    crudAction.getAllData().then((result) => {
          setState(() {
            productsForPdfListing = result;
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () => generatePdf(context, productsForPdfListing.documents) ,
          ),
          SizedBox(
            width: 10,
          ),
        ],
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () => refreshLists(),
        child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('products').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, int index) {
                  return Dismissible(
                    direction: DismissDirection.horizontal,
                    onDismissed: (direction) {
                      setState(() {
                        // snapshot.data.documents.removeAt(index) ;
                        crudAction.deleteProduct(
                            snapshot.data.documents[index].documentID);
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "Item succefully deleted",
                            style: TextStyle(color: Colors.black),
                          ),
                          backgroundColor: Colors.yellow,
                          action: SnackBarAction(
                            label: "UNDO",
                            onPressed: () {},
                          ),
                        ));
                      });
                    },
                    background: Container(
                      color: Colors.redAccent[100],
                    ),
                    child: ProductListing(
                      context: context,
                      documentSnapshot: snapshot.data.documents[index],
                    ),
                    key: Key("${snapshot.data.documents[index].documentID}"),
                  );
                },
              );
            }),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text("flock.sinasini@gmail.com"),
              accountName: Text("Sounish Nath"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("Assets/0.webp"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // InkWell(child: Text("Home")),
                  // InkWell(child: Text("Add Product")),
                  ListTile(
                    title: Text("Home"),
                  ),
                  ListTile(
                    title: Text("Add Product"),
                  ),
                  ListTile(
                    title: Text("Developer"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return NewProductPage();
        })),
        tooltip: 'Increment',
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}

// generatePdf(BuildContext context, productsForPdfListing.documents) 

// generatePdf(BuildContext context) async {
//   final data = productsForPdfListing.documents;

//   final pdfLib.Document pdf = pdfLib.Document(deflate: zlib.encode);
//   pdf.addPage(pdfLib.MultiPage(
//       build: (context) => [
//             pdfLib.Column(
//               mainAxisAlignment: pdfLib.MainAxisAlignment.center,
//               crossAxisAlignment: pdfLib.CrossAxisAlignment.center,
//               children: <pdfLib.Widget>[
//               pdfLib.Text("Stock Managments Details",
//                 style: pdfLib.TextStyle(
//                   fontSize: 22
//                 )
//               ),
//               pdfLib.SizedBox(height: 20),
//               pdfLib.Table.fromTextArray(context: context, data: <List<String>>[
//                 <String>[
//                   // "ID",
//                   "Product Name",
//                   "Quantity",
//                   "Cost Price",
//                   "Sell Price"
//                 ],
//                 ...data.map((item) => [
//                       // item.documentID,
//                       item.data["productName"],
//                       item.data['quantity'],
//                       item.data['costPrice'],
//                       item.data['sellPrice']
//                     ])
//               ]),
//             ])
//           ]));

//   final String dir = (await getApplicationDocumentsDirectory()).path;
//   final String path = '$dir/${DateTime.now()}.pdf';
//   final File file = File(path);
//   await file.writeAsBytes(pdf.save());
//   Navigator.of(context).push(
//     MaterialPageRoute(
//       builder: (_) => PdfViewerPage(path: path),
//     ),
//   );
// }

class DataSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.arrow_menu,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return InkWell(
      onTap: () {
        _showDialoauge(context);
      },
    );
  }

  _showDialoauge(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog();
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // final productDetailsLists = query.isEmpty ? allProducts.documents.toList() : allProducts.documents[0].data['productName'].where((p) => p.startsWith(query).toList() ) ;

    // final productDetailsList = query.isEmpty ? allProducts.documents.toList() : allProducts.documents[allProducts.documents.length].data['productName'].toString().startsWith(query) ;

    return ListView.builder(
        itemCount: allProducts.documents.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(Icons.lightbulb_outline),
            title: Text.rich(
              TextSpan(
                text: allProducts.documents[index].data['productName'],
                style: TextStyle(),
              ),
            ),
            subtitle:
                Text(allProducts.documents[index].data['quantity'].toString()),
            trailing: Text(
              "₹ " + allProducts.documents[index].data['sellPrice'].toString(),
              style: TextStyle(fontSize: 20),
            ),
          );
        });
  }
}

//  allProducts.documents[index].data['productName']

// generatePdf(context, allProducts.documents)
