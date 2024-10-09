import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf_reader/controller/notification_controller.dart';
import 'package:pdf_reader/features/app_theme.dart';
import 'package:pdf_reader/screens/about_page.dart';
import 'package:pdf_reader/screens/pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  String? downloadPath;
  bool _isPickingFile = false;
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _loadDownloadPath();

    NotificationService.showWeeklyNotification(
      title: 'title_notification'.tr(),
      body: 'body_notification'.tr(),
      payload: 'rate_app',
    );

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: const Offset(0, 0.1),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppBarColor.primaryColor,
        centerTitle: true,
        title: Text(
          'text_appbar'.tr(),
          style: GoogleFonts.jetBrainsMono(
            textStyle: TextStyle(
              color: FontTextColor.secondaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: BottomColor.primaryColor,
        tooltip: 'open_pdf'.tr(),
        onPressed: _isPickingFile ? null : _pickFile,
        child: Icon(
          Icons.add,
          size: 28,
          color: IconColor.secondaryColor,
          semanticLabel: 'icon_add'.tr(),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 100,
        color: BottomColor.primaryColor,
        shape: const CircularNotchedRectangle(),
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.home,
                      color: IconColor.secondaryColor,
                      semanticLabel: 'info_home'.tr(),
                    ),
                  ),
                  Text(
                    'Home',
                    style: GoogleFonts.jetBrainsMono(
                      color: FontTextColor.secondaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutPage(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.info,
                      color: IconColor.secondaryColor,
                      semanticLabel: 'info_icon'.tr(),
                    ),
                  ),
                  Text(
                    'About',
                    style: GoogleFonts.jetBrainsMono(
                      color: FontTextColor.secondaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/imgs/nodata.png',
                      height: 100,
                      semanticLabel: 'image_home'.tr(),
                    ),
                    const SizedBox(height: 100),
                    Text(
                      'about_home'.tr(),
                      style: GoogleFonts.jetBrainsMono(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'about_home_two'.tr(),
                style: GoogleFonts.jetBrainsMono(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return SlideTransition(
                      position: _animation,
                      child: Icon(
                        Icons.arrow_downward,
                        semanticLabel: 'arrow_icon'.tr(),
                        size: 50,
                        color: IconColor.primaryColor,
                      ),
                    );
                  },
                ),
              ),
              downloadPath == null
                  ? Center(
                      child: CircularProgressIndicator(
                        color: IconColor.primaryColor,
                      ),
                    )
                  : FutureBuilder<List<FileSystemEntity>>(
                      future: Directory(downloadPath!).list().toList(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: IconColor.primaryColor,
                            ),
                          );
                        }

                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const SizedBox();
                        }

                        var files = snapshot.data!
                            .where((file) => file.path.endsWith('.pdf'))
                            .toList();

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: files.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                files[index].path.split('/').last,
                              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
