import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:price_list/PdfViewerPage.dart';
import 'package:pdf/widgets.dart' as pdfLib;


generatePdf(BuildContext context, List<DocumentSnapshot> productsForPdfListing) async {
  final data = productsForPdfListing;

  final pdfLib.Document pdf = pdfLib.Document(deflate: zlib.encode);
  pdf.addPage(pdfLib.MultiPage(
      build: (context) => [
            pdfLib.Column(
              mainAxisAlignment: pdfLib.MainAxisAlignment.center,
              crossAxisAlignment: pdfLib.CrossAxisAlignment.center,
              children: <pdfLib.Widget>[
              pdfLib.Text("Stock Managments Details",
                style: pdfLib.TextStyle(
                  fontSize: 28,
                  fontWeight: pdfLib.FontWeight.bold 
                )
              ),
              pdfLib.SizedBox(height: 10),
              pdfLib.Text("generated on ${DateTime.now()}",
              style: pdfLib.TextStyle(
                fontSize: 20,
                // fontWeight: pdfLib.FontWeight.bold
              )
              ),
              pdfLib.SizedBox(height: 20),
              pdfLib.Table.fromTextArray(context: context, data: <List<String>>[
                <String>[
                  // "ID",
                  "Product Name",
                  "Quantity",
                  "Cost Price",
                  "Sell Price"
                ],
                ...data.map((item) => [
                      // item.documentID,
                      item.data["productName"],
                      item.data['quantity'],
                      item.data['costPrice'],
                      item.data['sellPrice']
                    ])
              ]),
              pdfLib.SizedBox(height: 20),
              pdfLib.Text("My Price List", style: pdfLib.TextStyle(
                fontWeight: pdfLib.FontWeight.bold,
              )),
              pdfLib.Text("build by: Sounish Nath", style: pdfLib.TextStyle(
                fontWeight: pdfLib.FontWeight.bold,
              ))
            ])
          ]));

  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/${DateTime.now()}.pdf';
  final File file = File(path);
  await file.writeAsBytes(pdf.save());
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => PdfViewerPage(path: path),
    ),
  );
}