import 'dart:io';
import 'dart:developer' as logger show log;

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfUtils {
  PdfUtils._();

  static Future<File> generatePDF() async {
    final pdf = pw.Document();
    // fetching a directory to save our pdf to
    Directory filePath = await getApplicationDocumentsDirectory();

    // handling of images 
    final ByteData bytesImage =
        await rootBundle.load('assets/images/hand_phone.png');
    final Uint8List bgBytes = bytesImage.buffer.asUint8List();

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Image(
                  pw.MemoryImage(bgBytes),
                  fit: pw.BoxFit.fitHeight,
                  height: 400,
                  width: 400,
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  "This is just an image caption!",
                  style: pw.TextStyle(
                    fontSize: 30,
                    color: PdfColors.red900,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    final pdfFile = File('${filePath.path}/my_example.pdf');
    logger.log('Saved to: ${pdfFile.path}');
    await pdfFile.writeAsBytes(await pdf.save());
    return pdfFile;
  }
}
