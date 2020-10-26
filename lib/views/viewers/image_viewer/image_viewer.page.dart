import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewerPage extends StatelessWidget {
  final String url;

  const ImageViewerPage({
    Key key,
    @required this.url,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
      body: PhotoView(
        imageProvider: CachedNetworkImageProvider(url),
      ),
    );
  }
}
