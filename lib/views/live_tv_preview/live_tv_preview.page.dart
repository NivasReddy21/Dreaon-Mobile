import '../../global_widgets/circular_image.dart';
import '../../utils/utils.dart';
import 'package:video_player/video_player.dart';

import '../../models/live_tv.dart';
import 'package:flutter/material.dart';

import 'widgets/play_pause_overlay.dart';

class LiveTvPreviewPage extends StatefulWidget {
  final LiveTv liveTv;

  const LiveTvPreviewPage({
    Key key,
    this.liveTv,
  }) : super(key: key);

  @override
  _LiveTvPreviewPageState createState() => _LiveTvPreviewPageState();
}

class _LiveTvPreviewPageState extends State<LiveTvPreviewPage> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.liveTv.video,
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) {
      setState(() {});
      _controller.play();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final video = Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
      child: Visibility(
        visible: _controller.value.initialized,
        replacement: Center(
          child: CircularProgressIndicator(),
        ),
        child: Column(children: [
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                VideoPlayer(_controller),
                PlayPauseOverlay(
                  controller: _controller,
                ),
                VideoProgressIndicator(_controller, allowScrubbing: true),
              ],
            ),
          ),
        ]),
      ),
    );

    final userDetails = Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircularImage(
              image: widget.liveTv.user.photo,
              size: 40.0,
            ),
            title: Text(
              widget.liveTv.user.name,
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              "${Utils.formatNumber(widget.liveTv.views)} views | ${Utils.formatNumber(widget.liveTv.comments)} comments",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Utils.verticalSpacer(space: 15),
            Text(
              widget.liveTv.videoTitle,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            userDetails,
            video
          ],
        ),
      ),
    );
  }
}
