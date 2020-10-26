import 'package:buddy/services/db.dart';

import '../../../utils/utils.dart';
import '../../../global_widgets/icon_button.dart';
import '../../../models/post.dart';
import '../../../services/bottom_sheet.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class PostDetailsActions extends StatefulWidget {
  final Post post;

  const PostDetailsActions({Key key, this.post}) : super(key: key);
  @override
  _PostDetailsActionsState createState() => _PostDetailsActionsState();
}

class _PostDetailsActionsState extends State<PostDetailsActions> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconBtn(
            leadingIcon:
                widget.post.isLiked ? Icons.favorite : Icons.favorite_border,
            value: widget.post.likesCount,
            color: widget.post.isLiked ? Theme.of(context).primaryColor : null,
            onTap: () async {
              await FirebaseProviver()
                  .like(widget.post.user.id, widget.post.postId);
            },
          ),
          Utils.horizontalSpacer(
            space: 10,
          ),
          IconBtn(
            leadingIcon: FlutterIcons.share_2_fea,
            value: widget.post.sharesCount,
            onTap: () => BottomSheetService().showShare(context: context),
          ),
        ],
      ),
    );
  }
}
