import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf_reader/features/app_theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewer extends StatelessWidget {
  final String filePath;

  const PDFViewer({required this.filePath, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppBarColor.primaryColor,
        iconTheme: IconThemeData(color: IconColor.secondaryColor),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            semanticLabel: 'button_return'.tr(),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          tooltip: 'return'.tr(),
        ),
        title: Text(
          'pdf_view'.tr(),
          style: GoogleFonts.jetBrainsMono(
            textStyle: TextStyle(
              color: FontTextColor.secondaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
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
