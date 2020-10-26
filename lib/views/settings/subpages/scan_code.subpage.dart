import '../../../constants/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ScanCodeSubpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = AppData.users.singleWhere((e) => e.id == '', orElse: null);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      child: Column(
        children: <Widget>[
          QrImage(
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            data: 'You can call me EMRADE',
            version: QrVersions.auto,
            size: 200,
            gapless: false,
            embeddedImage: AssetImage(user.photo),
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size(80, 80),
            ),
          ),
          Text(
            "Scan QR code to follow me",
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyText1.color),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              iconButton(FlutterIcons.download_fea, "Save QR code"),
              iconButton(FlutterIcons.qrcode_scan_mco, "Scan"),
            ],
          )
        ],
      ),
    );
  }

  Widget iconButton(IconData icon, String title, {VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Icon(
            icon,
            size: 40.0,
          ),
          SizedBox(height: 10.0),
          Text(title)
        ],
      ),
    );
  }
}
