import 'package:pdf/widgets.dart' as pw;

pw.Widget textItem({
  required String title,
  pw.TextStyle style = const pw.TextStyle(fontSize: 30),
}) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(5),
    child: pw.Text(title, style: style),
  );
}
