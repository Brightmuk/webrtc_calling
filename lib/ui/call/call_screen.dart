import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:go_router/go_router.dart';
import 'package:webrtc_tutorial/services/signaling_service.dart';

class CallScreen extends StatefulWidget {
  final String? roomId;
  const CallScreen({Key? key, required this.roomId}) : super(key: key);

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  SignalingService signaling = SignalingService.instance;
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String? roomId;
  bool _remoteConnected = false;

  @override
  void initState() {
    super.initState();
    roomId = widget.roomId;
    initService();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  Future<void> initService() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
    signaling.onAddRemoteStream = ((stream) {
      debugPrint("\n\nREMOTE STREAM ADDED: $stream\n\n");
      _remoteRenderer.srcObject = stream;
      setState(() {});
    });
    if (widget.roomId != null) {
      //In this case we are joining
      signaling.openUserMedia(_localRenderer, _remoteRenderer).then((v) {
        setState(() {});
      });
    } else {
      //In this case its a new call
      signaling.openUserMedia(_localRenderer, _remoteRenderer).then((v) async {
        String _roomId = await signaling.createRoom();
        setState(() {
          roomId = _roomId;
        });
      });
    }
    signaling.peerConnection?.onIceConnectionState = (state) {
  if (state == RTCIceConnectionState.RTCIceConnectionStateConnected) {
    setState(() => _remoteConnected = true);
  } else if (state == RTCIceConnectionState.RTCIceConnectionStateDisconnected ||
             state == RTCIceConnectionState.RTCIceConnectionStateFailed) {
    setState(() => _remoteConnected = false);
  }
};

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: _remoteConnected? RTCVideoView(
              _remoteRenderer,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
            ): Stack(
          fit: StackFit.expand,
          children: [
            RTCVideoView(
              _localRenderer,
              mirror: true,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
            ),
            
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                color: Colors.black.withAlpha(100),
              ),
            ),
            
            Center(
              child: Text(
                "Waiting for other participant...",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ),
          ],
        ),
          ),

          Positioned(
            top: 40,
            right: 16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 120,
                height: 180,
                child: RTCVideoView(
                  _localRenderer,
                  mirror: true,
                  objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 40),
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Room ID: $roomId',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Icon(Icons.call_end,color: Colors.white,),
        onPressed: () {
          signaling.hangUp(_localRenderer);
          context.go('/');
        },
      ),
    );
  }
}
