import 'package:buddy/models/user.dart';
import 'package:buddy/services/authentication.service.dart';

import '../../services/bottom_sheet.service.dart';
import '../../views/settings/subpages/account.subpage.dart';
import '../../views/settings/subpages/content_pref.subpage.dart';
import '../../views/settings/subpages/data_saver.subpage.dart';
import '../../views/settings/subpages/language.subpage.dart';
import '../../views/settings/subpages/privacy_policy.subpage.dart';
import '../../views/settings/subpages/privacy_safety.subpage.dart';
import '../../views/settings/subpages/push_notifications.subpage.dart';
import '../../views/settings/subpages/report_problem.subpage.dart';
import '../../views/settings/subpages/scan_code.subpage.dart';
import '../../views/settings/subpages/terms_of_use.subpage.dart';

import '../../models/settings_base_view.dart';
import 'subpages/theme.subpage.dart';

import '../../constants/routes.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'widgets/icon_tile.dart';

import 'widgets/header.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void navigateTo(
    String title,
    Widget widget,
  ) {
    Navigator.of(context).pushNamed(
      AppRoutes.settingsBase,
      arguments: SettingsBaseView(title: title, body: widget),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hr = Divider(
      thickness: 0.5,
    );
    final account = Container(
      margin: EdgeInsets.only(top: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            text: "Account",
          ),
          IconTile(
            icon: FlutterIcons.user_fea,
            title: "Manage my account",
            onTap: () => navigateTo(
                "Manage my account",
                AccountSubpage(
                  user: User(),
                )),
          ),
          IconTile(
            icon: FlutterIcons.lock_fea,
            title: "Privacy and safety",
            onTap: () =>
                navigateTo("Privacy and safety", PrivacySafetySubpage()),
          ),
          IconTile(
            icon: FlutterIcons.videocamera_ant,
            title: "Content preferences",
            onTap: () => navigateTo(
              "Content preferences",
              ContentPrefSubPage(),
            ),
          ),
          IconTile(
            icon: FlutterIcons.share_2_fea,
            title: "Share profile",
            onTap: () => BottomSheetService().showShare(context: context),
          ),
          IconTile(
            icon: FlutterIcons.qrcode_scan_mco,
            title: "Scan code",
            onTap: () => navigateTo("Scan code", ScanCodeSubpage()),
          ),
          hr
        ],
      ),
    );

    final general = Container(
      margin: EdgeInsets.only(top: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            text: "General",
          ),
          IconTile(
            icon: FlutterIcons.sun_fea,
            title: "Theme",
            onTap: () => navigateTo("Theme", ThemeSubpage()),
          ),
          IconTile(
            icon: FlutterIcons.bell_fea,
            title: "Push notifications",
            onTap: () => navigateTo(
              "Push Notifications",
              PushNotificationsSubpage(),
            ),
          ),
          IconTile(
            icon: FlutterIcons.language_ent,
            title: "Language",
            onTap: () => navigateTo("Language", LanguageSubpage()),
          ),
          IconTile(
            icon: FlutterIcons.droplet_fea,
            title: "Data Saver",
            onTap: () => navigateTo("Data Saver", DataSaverSubpage()),
          ),
          hr
        ],
      ),
    );

    final support = Container(
      margin: EdgeInsets.only(top: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            text: "Support",
          ),
          IconTile(
            icon: FlutterIcons.edit_fea,
            title: "Report a problem",
            onTap: () => navigateTo("Report a problem", ReportProblemSubpage()),
          ),
          hr
        ],
      ),
    );

    final about = Container(
      margin: EdgeInsets.only(top: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
            text: "About",
          ),
          IconTile(
            icon: FlutterIcons.file_fea,
            title: "Privacy Policy",
            onTap: () => navigateTo("Privacy Policy", PrivacyPolicySubpage()),
          ),
          IconTile(
            icon: FlutterIcons.edit_fea,
            title: "Terms of use",
            onTap: () => navigateTo("Terms of use", TermsOfUseSubpage()),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings and privacy",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        elevation: 1,
        actions: <Widget>[
          IconButton(
              icon: Icon(FlutterIcons.log_out_fea),
              onPressed: () {
                Authentication().signOut(context);
              }),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            account,
            general,
            support,
            about,
          ],
        ),
      ),
    );
  }
}
