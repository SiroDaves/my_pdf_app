import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';

import '../utils/pdf_utils.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  late PDFDocument pdfDoc;

  void openPdfViewer() {
    final pdfViewer = PDFViewer(document: pdfDoc);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => pdfViewer),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('My PDF App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final pdf = await PdfUtils.generatePDF();
            pdfDoc = await PDFDocument.fromFile(pdf);
            openPdfViewer();
          },
          child: const Text('Generate PDF'),
        ),
      ),
    );
  }
}
