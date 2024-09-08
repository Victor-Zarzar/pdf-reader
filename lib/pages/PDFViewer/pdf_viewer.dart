import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewer extends StatelessWidget {
  final String filePath;

  const PDFViewer({required this.filePath, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade700,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'pdf_view'.tr(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SfPdfViewer.file(
        File(filePath),
        canShowScrollHead: true,
        canShowScrollStatus: true,
        enableTextSelection: true,
      ),
    );
  }
}
