import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pdf_reader/features/app_theme.dart';
import 'package:pdf_reader/view/widget/responsive_extension.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('${'launch_error'.tr()} $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, semanticLabel: 'button_return'.tr()),
          onPressed: () {
            Navigator.pop(context);
          },
          tooltip: 'return'.tr(),
        ),
        title: Text("about_page".tr(), style: context.h1),
        centerTitle: true,
        backgroundColor: AppBarColor.primaryColor,
        iconTheme: IconThemeData(color: IconColor.secondaryColor),
      ),
      body: SizedBox(
        height: myHeight,
        width: myWidth,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: Text(
                  'about_text'.tr(),
                  textAlign: TextAlign.center,
                  style: context.bodySmallDark,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  _launchUrl('https://www.victorzarzar.com.br');
                },
                child: Center(
                  child: Text(
                    'developed'.tr(),
                    textAlign: TextAlign.center,
                    style: context.footerMediumFontSemiBold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
