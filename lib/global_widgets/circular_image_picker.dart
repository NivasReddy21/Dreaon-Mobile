import 'dart:io';

import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class CircularImagePicker extends StatelessWidget {
  final double size;
  final double imagePy;
  final VoidCallback onPressed;
  final File file;
  final bool showIcon;
  final String assetImage;

  const CircularImagePicker({
    Key key,
    this.size = 100.0,
    this.imagePy = 10.0,
    @required this.onPressed,
    this.file,
    this.showIcon = false,
    this.assetImage,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userImage = Container(
      margin: EdgeInsets.only(right: 10.0),
      padding: EdgeInsets.all(2.0),
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          image: file == null
              ? assetImage == null
                  ? null
                  : DecorationImage(
                      image: NetworkImage(assetImage),
                      fit: BoxFit.cover,
                    )
              : DecorationImage(
                  image: FileImage(file),
                  fit: BoxFit.cover,
                ),
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
          color: Colors.grey.withOpacity(0.5),
        ),
        child: Visibility(
          visible: file == null && assetImage == null,
          child: Icon(
            LineAwesomeIcons.image,
            color: Colors.white,
            size: 40.0,
          ),
        ),
      ),
    );

    final icon = Positioned(
      bottom: imagePy,
      right: 0,
      child: Visibility(
        visible: showIcon,
        child: Container(
          height: 30.0,
          width: 30.0,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).primaryColor,
            ),
          ),
          child: Icon(
            Icons.camera_alt,
            size: 18.0,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );

    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: <Widget>[
          userImage,
          icon,
        ],
      ),
    );
  }
}
