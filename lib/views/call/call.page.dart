import 'dart:async';

import '../../constants/data.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../utils/utils.dart';
import 'widgets/call_button.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../global_widgets/circular_image.dart';
import 'package:flutter/material.dart';
import '../../models/call.dart';

class CallPage extends StatefulWidget {
  final Call call;

  const CallPage({
    Key key,
    this.call,
  }) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  bool voiceCallRinging = true;
  bool videoCallRinging = true;
  bool isVideoCall;
  bool isMute = false;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  Timer timer;

  @override
  void initState() {
    isVideoCall = widget.call.isVideo;

    timer = Timer(new Duration(seconds: 2), () {
      callAnswered();
    });
    super.initState();
  }

  void callAnswered() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    setState(() {
      voiceCallRinging = false;
      videoCallRinging = false;
    });
  }

  void setIsVideoCall(bool value) {
    setState(() {
      isVideoCall = value;
    });
  }

  void toggleVideoCall() {
    setState(() {
      isVideoCall = !isVideoCall;
    });
  }

  void toggleMute() {
    setState(() {
      isMute = !isMute;
    });
  }

  @override
  void dispose() async {
    super.dispose();
    timer.cancel();
    timer = null;
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final userAndTimer = Column(
      children: <Widget>[
        Text(
          widget.call.user.name,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        Visibility(
          visible: videoCallRinging,
          child: Text(
            "Ringing..",
            style: TextStyle(color: Colors.white),
          ),
        ),
        Visibility(
          visible: !videoCallRinging,
          child: _buildCallTimer(),
        ),
      ],
    );

    final voiceCall = Align(
      alignment: Alignment.topCenter,
      child: Visibility(
        visible: !isVideoCall,
        child: Container(
          margin: EdgeInsets.only(top: screenHeight * 0.2),
          child: Column(
            children: [
              CircularImage(
                image: widget.call.user.photo,
                size: 100,
              ),
              Utils.verticalSpacer(space: 10),
              userAndTimer,
            ],
          ),
        ),
      ),
    );

    final videoCall = Align(
      alignment: Alignment.topLeft,
      child: Visibility(
        visible: isVideoCall,
        child: Container(
          margin: EdgeInsets.only(top: 50.0, left: 20.0),
          child: Column(
            children: [
              Container(
                height: 160.0,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  image: DecorationImage(
                    image: AssetImage(
                      AppData.users
                          .singleWhere((e) => e.id == '', orElse: null)
                          .photo,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    final callActions = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Visibility(
                visible: isVideoCall,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: userAndTimer,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CallButton(
                    icon: isVideoCall
                        ? FlutterIcons.voice_mco
                        : FlutterIcons.videocamera_ant,
                    iconColor: Colors.black,
                    onTap: () => toggleVideoCall(),
                  ),
                  CallButton(
                    icon: FlutterIcons.call_end_sli,
                    iconColor: Colors.white,
                    size: 24.0,
                    color: Colors.red,
                    onTap: () => Navigator.pop(context),
                  ),
                  CallButton(
                    icon: isMute
                        ? FlutterIcons.mic_fea
                        : FlutterIcons.mic_off_fea,
                    iconColor: Colors.black,
                    onTap: () => toggleMute(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  widget.call.user.photo,
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.7),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          voiceCall,
          videoCall,
          callActions
        ],
      ),
    );
  }

  Widget _buildCallTimer() {
    return StreamBuilder<int>(
      stream: _stopWatchTimer.rawTime,
      initialData: 0,
      builder: (context, snap) {
        final value = snap.data;
        final displayTime =
            StopWatchTimer.getDisplayTime(value, milliSecond: false);
        return Column(
          children: <Widget>[
            Text(
              displayTime,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ],
        );
      },
    );
  }
}
