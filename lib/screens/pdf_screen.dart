import 'dart:io';
import 'dart:developer' as logger show log;

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class PdfScreen extends StatefulWidget {
  final File pdf;
  const PdfScreen({Key? key, required this.pdf}) : super(key: key);

  @override
  PdfScreenState createState() => PdfScreenState();
}

@visibleForTesting
class PdfScreenState extends State<PdfScreen> {
  Future<PDFViewer> preparePdfDocument() async {
    try {
      final pdfDoc = await PDFDocument.fromFile(widget.pdf);
      return PDFViewer(
        document: pdfDoc,
        scrollDirection: Axis.vertical,
        showNavigation: false,
      );
    } catch (e) {
      logger
          .log('Error Log: We are unable to open that PDF. We ran into an $e');
      return PDFViewer(document: PDFDocument());
    }
  }

  @override
  Widget build(BuildContext context) {
    String pdfTitle = basename(widget.pdf.path);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(pdfTitle),
        actions: [
          InkWell(
            onTap: () async {},
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.share, size: 35),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: preparePdfDocument(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(child: snapshot.data);
          } else {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.warning, size: 160),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Just a minute',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red, fontSize: 16)),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
