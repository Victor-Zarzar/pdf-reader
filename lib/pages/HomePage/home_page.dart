import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pdf_reader/pages/PDFViewer/pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? downloadPath;
  bool _isPickingFile = false;

  @override
  void initState() {
    super.initState();
    _loadDownloadPath();
  }

  Future<void> _loadDownloadPath() async {
    String? path = await getDownloadPath();
    if (mounted) {
      setState(() {
        downloadPath = path;
      });
    }
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    if (Platform.isAndroid) {
      directory = Directory('/storage/emulated/0/Download');
    } else if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    }
    return directory?.path;
  }

  Future<void> _pickFile() async {
    if (_isPickingFile) return;

    setState(() {
      _isPickingFile = true;
    });

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        String filePath = result.files.single.path!;
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PDFViewer(filePath: filePath),
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('${'error_selecting_file'.tr()}: $e');
    } finally {
      setState(() {
        _isPickingFile = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'text_appbar'.tr(),
        ),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _isPickingFile ? null : _pickFile,
            child: Text(
              'text_button'.tr(),
            ),
          ),
          Expanded(
            child: downloadPath == null
                ? const Center(child: CircularProgressIndicator())
                : FutureBuilder<List<FileSystemEntity>>(
                    future: Directory(downloadPath!).list().toList(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      var files = snapshot.data!
                          .where((file) => file.path.endsWith('.pdf'))
                          .toList();

                      return ListView.builder(
                        itemCount: files.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(files[index].path.split('/').last),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PDFViewer(
                                    filePath: files[index].path,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
