import 'dart:io';

import 'package:flutter/material.dart';

import '../data/student.dart';
import '../utils/pdf_utils.dart';
import 'pdf_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  late File pdfFile;
  List<Student> students = [
    Student(name: 'John James', cat1: 20, cat2: 15, endterm: 30),
    Student(name: 'Peter Williams', cat1: 25, cat2: 15, endterm: 65),
    Student(name: 'Otieno Atieno', cat1: 5, cat2: 7, endterm: 40),
    Student(name: 'Kamau Karanja', cat1: 28, cat2: 30, endterm: 95),
    Student(name: 'Wafula Njanjala', cat1: 11, cat2: 22, endterm: 85),
    Student(name: 'CarlMax Washington', cat1: 9, cat2: 14, endterm: 60),
    Student(name: 'Joseph Prince', cat1: 23, cat2: 20, endterm: 66),
    Student(name: 'Sabdio Galgalo', cat1: 20, cat2: 20, endterm: 75),
    Student(name: 'Brenda Gasheri', cat1: 10, cat2: 15, endterm: 55),
    Student(name: 'Cosmas Korir', cat1: 11, cat2: 5, endterm: 25),
  ];

  void openPdfViewer() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfScreen(pdf: pdfFile),
      ),
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
            pdfFile = await PdfUtils.generateAdvancedPDF(students);
            openPdfViewer();
          },
          child: const Text('Generate PDF'),
        ),
      ),
    );
  }
}
