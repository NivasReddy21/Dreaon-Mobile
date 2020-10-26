import '../../../constants/routes.dart';
import '../../../models/live_tv.dart';
import '../../../utils/utils.dart';
import 'package:flutter/material.dart';

class LiveTvTile extends StatelessWidget {
  final LiveTv liveTv;

  const LiveTvTile({
    Key key,
    this.liveTv,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final details = Positioned(
      bottom: 10,
      left: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(
              liveTv.videoTitle,
              style: TextStyle(
                color: Colors.white,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            "${Utils.formatNumber(liveTv.views)} views",
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );

    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        AppRoutes.liveTvPreview,
        arguments: liveTv,
      ),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                image: NetworkImage(liveTv.videoThumb),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3),
                  BlendMode.darken,
                ),
              ),
            ),
            // child: details,
          ),
          details
        ],
      ),
    );
  }
}
