import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class PDFScreen extends StatefulWidget {
  const PDFScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  String? _localFilePath;

  @override
  void initState() {
    super.initState();
    _loadPDF();
  }

  Future<void> _loadPDF() async {
    // Load the PDF file from assets
    final ByteData data = await rootBundle.load('assets/yaseen.pdf');
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/sample.pdf';
    final File file = File(path);

    await file.writeAsBytes(data.buffer.asUint8List(), flush: true);

    setState(() {
      _localFilePath = path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: _localFilePath != null
          ? PDFView(
              filePath: _localFilePath,
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
