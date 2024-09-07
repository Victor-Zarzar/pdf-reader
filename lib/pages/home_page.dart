import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:permission_handler/permission_handler.dart';

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
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    if (Platform.isAndroid) {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        _loadDownloadPath();
      } else {
        debugPrint('Permissão de armazenamento negada');
      }
    } else {
      _loadDownloadPath();
    }
  }

  Future<void> _loadDownloadPath() async {
    String? path = await getDownloadPath();
    setState(() {
      downloadPath = path;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leitor de PDF'),
      ),
      body: downloadPath == null
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
    );
  }
}
