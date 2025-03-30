import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf_reader/controller/notification_controller.dart';
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
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: ListTile(
                title: Text('notifications'.tr()),
                trailing: Switch(
                  value: notificationController.notificationsEnabled,
                  onChanged: notificationController.toggleNotifications,
                  activeColor: Colors.red,
                  inactiveTrackColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
