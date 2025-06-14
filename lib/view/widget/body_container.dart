import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pdf_reader/features/app_assets.dart';
import 'package:pdf_reader/features/app_theme.dart';
import 'package:pdf_reader/view/pdf_viewer.dart';
import 'package:pdf_reader/view/widget/responsive_extension.dart';

class BodyContainer extends StatelessWidget {
  const BodyContainer({
    super.key,
    required Animation<Offset> animation,
    required this.downloadPath,
  }) : _animation = animation;

  final Animation<Offset> _animation;
  final String? downloadPath;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageOne.asset(),
                  const SizedBox(height: 100),
                  Text(
                    'about_home'.tr(),
                    style: context.bodySmallDarkBold,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text('about_home_two'.tr(), style: context.bodySmallDarkBold),
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
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: IconColor.primaryColor,
                        ),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const SizedBox();
                    }

                    var files =
                        snapshot.data!
                            .where((file) => file.path.endsWith('.pdf'))
                            .toList();

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: files.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(files[index].path.split('/').last),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        PDFViewer(filePath: files[index].path),
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
    );
  }
}
