import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:meta/meta.dart';
import 'package:webrtc_tutorial/services/signaling_service.dart';

part 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  final String? roomId;
  CallCubit(this.roomId) : super(CallInitial()) {
    _init();
  }
  SignalingService _signaling = SignalingService.instance;
  RTCVideoRenderer localRenderer = RTCVideoRenderer();
  RTCVideoRenderer remoteRenderer = RTCVideoRenderer();
  int version = 0;
  String _roomId = '#';
  String _stateText = "Waiting for other participant...";
  bool _remoteConnected = false;
  bool get remoteConnected => _remoteConnected;

  late final StreamSubscription _connectionChangeSub;
  late final StreamSubscription _remoteStreamSub;

  void _init() async {
    await localRenderer.initialize();
    await remoteRenderer.initialize();
    _remoteStream();
    _connectionStream();
    _localMediaInit();
  }

  void _connectionStream() {
    _connectionChangeSub =  _signaling.onConnectionStateChangeC.stream.listen((connectionState) {
      if (connectionState ==
          RTCPeerConnectionState.RTCPeerConnectionStateConnected) {
        _remoteConnected = true;
      }else if(connectionState == RTCPeerConnectionState.RTCPeerConnectionStateClosed){
        _stateText = "Participant left the call";
      } else {
        _remoteConnected = false;
      }
      emit(CallInitialised(version: ++version, roomId: _roomId,stateText: _stateText));
    });
  }

  void _remoteStream() {
    _remoteStreamSub =  _signaling.onAddRemoteStreamC.stream.listen((stream) {
      remoteRenderer.srcObject = stream;
      emit(CallInitialised(version: ++version, roomId: _roomId, stateText: _stateText));
    });
  }

  void _localMediaInit() {
    if (roomId != null) {
      //In this case we are joining
      _roomId = roomId!;
      _signaling.openUserMedia(localRenderer, remoteRenderer).then((v) {
        emit(CallInitialised(version: ++version, roomId: _roomId, stateText: _stateText));
      });
    } else {
      //In this case its a new call
      _signaling.openUserMedia(localRenderer, remoteRenderer).then((v) async {
        String createdRoomId = await _signaling.createRoom();
        _roomId = createdRoomId;
        emit(CallInitialised(version: ++version, roomId: _roomId, stateText:  _stateText));
      });
    }
  }

  void hangup() {
    _signaling.hangUp(localRenderer);
  }

  @override
  Future<void> close() async {
    localRenderer.dispose();
    remoteRenderer.dispose();
    _remoteStreamSub.cancel();
    _connectionChangeSub.cancel();
    
    super.close();
  }
}
