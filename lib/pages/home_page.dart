import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? downloadPath;

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
            builder: (context) => PDFView(filePath: filePath),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leitor de PDF'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _pickFile,
            child: const Text('Procurar Arquivo PDF'),
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
                                  builder: (context) => PDFView(
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
