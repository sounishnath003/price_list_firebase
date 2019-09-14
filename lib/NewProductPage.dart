import 'package:flutter/material.dart';

class NewProductPage extends StatefulWidget {
  NewProductPage({Key key}) : super(key: key);

  _NewProductPageState createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: _newProductPage(),
    );
  }


  _newProductPage() {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.white
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
           TextField(
             textInputAction: TextInputAction.next,
             maxLength: 15,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefix: Icon(Icons.text_fields),
                focusColor: Colors.yellow,
                hintText: "Enter product name"
                ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefix: Icon(Icons.text_fields),
                focusColor: Colors.yellow,
                hintText: "Enter quantity"
                ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefix: Icon(Icons.text_fields),
                focusColor: Colors.yellow,
                hintText: "Enter cost price (INR) "
                ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefix: Icon(Icons.text_fields),
                focusColor: Colors.yellow,
                hintText: "Enter sell price (INR) "
                ),
            ),
            SizedBox(
              height: 40,
            ),
            FlatButton(
              color: Colors.yellow,
              child: Text("SAVE",
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }


}

