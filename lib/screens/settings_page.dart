import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf_reader/controller/locale_controller.dart';
import 'package:pdf_reader/controller/notification_controller.dart';
import 'package:pdf_reader/features/app_assets.dart';
import 'package:pdf_reader/features/app_theme.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final notificationController = Provider.of<NotificationController>(context);
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
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
        iconTheme: IconThemeData(color: IconColor.secondaryColor),
        backgroundColor: AppBarColor.primaryColor,
        centerTitle: true,
        title: Text(
          'settings'.tr(),
          style: GoogleFonts.jetBrainsMono(
            textStyle: TextStyle(
              color: FontTextColor.secondaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: myHeight,
        width: myWidth,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: ListTile(
                leading: Icon(
                  Icons.translate,
                  color: IconColor.thirdColor,
                  size: 23,
                ),
                title: Text(
                  'language'.tr(),
                  style: GoogleFonts.jetBrainsMono(
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                trailing: PopupMenuButton<Locale>(
                  color: PopupMenuColor.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  icon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.language, color: IconColor.thirdColor),
                      const SizedBox(width: 4),
                      Text(
                        'english'.tr(),
                        style: GoogleFonts.jetBrainsMono(
                          textStyle: TextStyle(
                            color: TextColor.secondaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: IconColor.thirdColor,
                      ),
                    ],
                  ),
                  onSelected: (Locale locale) {
                    Provider.of<LocaleController>(
                      context,
                      listen: false,
                    ).changeLanguage(context, locale);
                  },
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      value: const Locale('en', 'US'),
                      child: Row(
                        children: [
                          EN.asset(),
                          const SizedBox(width: 8),
                          Text(
                            'english'.tr(),
                            style: GoogleFonts.jetBrainsMono(
                              textStyle: TextStyle(
                                color: TextColor.primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: const Locale('pt', 'BR'),
                      child: Row(
                        children: [
                          PTBR.asset(),
                          const SizedBox(width: 8),
                          Text(
                            'portuguese'.tr(),
                            style: GoogleFonts.jetBrainsMono(
                              textStyle: TextStyle(
                                color: TextColor.primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: const Locale('es'),
                      child: Row(
                        children: [
                          ES.asset(),
                          const SizedBox(width: 8),
                          Text(
                            'spanish'.tr(),
                            style: GoogleFonts.jetBrainsMono(
                              textStyle: TextStyle(
                                color: TextColor.primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            ListTile(
              title: Text(
                'notifications'.tr(),
                style: GoogleFonts.jetBrainsMono(
                  textStyle: TextStyle(
                    color: TextColor.secondaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              trailing: Switch(
                value: notificationController.notificationsEnabled,
                onChanged: notificationController.toggleNotifications,
                activeColor: SwitchColor.primaryColor,
                inactiveTrackColor: SwitchColor.secondaryColor,
              ),
              leading: Icon(
                Icons.dark_mode,
                color: IconColor.thirdColor,
                semanticLabel: 'notifications_icon'.tr(),
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
