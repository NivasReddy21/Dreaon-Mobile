import '../../../constants/routes.dart';
import '../../../global_widgets/circular_image.dart';
import '../../../global_widgets/custom_button.dart';
import '../../../global_widgets/outline_gradient_button.dart';

import '../../../models/user.dart';
import 'package:flutter/material.dart';

class FollowerTile extends StatefulWidget {
  final User user;

  const FollowerTile({Key key, this.user}) : super(key: key);

  @override
  _FollowerTileState createState() => _FollowerTileState();
}

class _FollowerTileState extends State<FollowerTile> {
  List<bool> following = [true, false];
  bool currentFollowing;

  void follow(bool follow) {
    setState(() {
      currentFollowing = follow;
    });
  }

  @override
  void initState() {
    super.initState();
    following.shuffle();
    currentFollowing = following[0];
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).pushNamed(
        AppRoutes.profile,
        arguments: widget.user.id,
      ),
      contentPadding: EdgeInsets.zero,
      leading: CircularImage(image: widget.user.photo),
      title: Text(
        "${widget.user.username}",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(widget.user.name),
      trailing: !currentFollowing
          ? SizedBox(
              width: 100.0,
              height: 35.0,
              child: CustomButton(
                wrap: true,
                onPressed: () => follow(true),
                text: "Follow",
              ),
            )
          : OutlineGradientButton(
              text: "Following",
              onPressed: () => follow(false),
              padding: EdgeInsets.symmetric(horizontal: 10),
            ),
    );
  }
}
