import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:price_list/NewProductPage.dart';
import 'package:price_list/ProductListing.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Icon(Icons.search),
          SizedBox(width: 10,),
          Icon(Icons.photo_camera),
          SizedBox(width: 10,),
          Icon(Icons.list),
          SizedBox(width: 10,),
        ],
        title: Text(widget.title),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, int index) {
              return ProductListing(
                context: context,
                documentSnapshot: snapshot.data.documents[index],
                );
            },
            );
        }
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
                    ListTile(title: Text("Home"),),
                    ListTile(title: Text("Add Product"),),
                    ListTile(title: Text("Developer"),),
                  ],
                ),
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => NewProductPage() ,
        tooltip: 'Increment',
        child: Icon(Icons.add, size: 30,),
      ), 
    );
  }
}
