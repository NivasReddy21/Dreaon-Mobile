import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String url;

  const CachedImage({
    Key key,
    @required this.url,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        progressIndicatorBuilder: (context, url, progress) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(
                value: progress.progress,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            ),
          );
        },
        errorWidget: (context, url, error) {
          return Icon(
            Icons.error,
          );
        },
      ),
    );
  }
}
