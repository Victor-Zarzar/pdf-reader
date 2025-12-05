import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pdf_reader/features/app_theme.dart';
import 'package:pdf_reader/features/repsonsive_extension.dart';
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
            Icons.keyboard_arrow_left,
            semanticLabel: 'button_return'.tr(),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          tooltip: 'return'.tr(),
        ),
        title: Text('pdf_view'.tr(), style: context.h1),
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
