import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pdf_reader/features/app_theme.dart';
import 'package:pdf_reader/features/repsonsive_extension.dart';
import 'package:pdf_reader/view/about_page.dart';

class TabBarFooter extends StatelessWidget {
  const TabBarFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
                  'home'.tr(),
                  style: context.footerMediumFont,
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
                  'about_page'.tr(),
                  style: context.footerMediumFont,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
