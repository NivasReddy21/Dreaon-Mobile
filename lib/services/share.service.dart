import 'package:buddy/models/post.dart';
import 'package:buddy/services/dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ShareService {
  void share(BuildContext context, Post post) async {
    final RenderBox box = context.findRenderObject();
    final uri = await DynamicLinkService().postLink(post);
    Share.share(uri,
        subject: "Check Out My Post On Dreaon!",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
