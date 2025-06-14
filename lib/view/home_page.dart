import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pdf_reader/controller/locale_controller.dart';
import 'package:pdf_reader/features/app_theme.dart';
import 'package:pdf_reader/view/pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_reader/view/settings_page.dart';
import 'package:pdf_reader/view/widget/tab_bar.dart';
import 'package:pdf_reader/view/widget/body_container.dart';
import 'package:pdf_reader/view/widget/responsive_extension.dart';
import 'package:provider/provider.dart';

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

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: const Offset(0, 0.1),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
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
    final currentLocale = context.locale;
    return Consumer<LocaleController>(
      builder: (context, languageProvider, child) {
        return Scaffold(
          key: ValueKey(currentLocale),
          appBar: AppBar(
            backgroundColor: AppBarColor.primaryColor,
            centerTitle: true,
            title: Text('text_appbar'.tr(), style: context.h1),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: IconColor.secondaryColor,
                  semanticLabel: 'settings_icon'.tr(),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  );
                },
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
          bottomNavigationBar: TabBarFooter(),
          body: BodyContainer(
            animation: _animation,
            downloadPath: downloadPath,
          ),
        );
      },
    );
  }
}
