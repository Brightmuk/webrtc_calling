import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webrtc_tutorial/ui/call/call_cubit.dart';

class CallScreen extends StatelessWidget {
  final String? roomId;
  const CallScreen({Key? key, required this.roomId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CallCubit(roomId),
      child: BlocConsumer<CallCubit, CallState>(
        listener: (context, state) {
          
        },
        builder: (context, state) {
          final CallCubit _calllCubit = context.read<CallCubit>();
          if (state is CallInitialised) {
            return Scaffold(
              body: Stack(
                children: [
                  Positioned.fill(
                    child:
                        _calllCubit.remoteConnected
                            ? RTCVideoView(
                              _calllCubit.remoteRenderer,
                              objectFit:
                                  RTCVideoViewObjectFit
                                      .RTCVideoViewObjectFitCover,
                            )
                            : Stack(
                              fit: StackFit.expand,
                              children: [
                                RTCVideoView(
                                  _calllCubit.localRenderer,
                                  mirror: true,
                                  objectFit:
                                      RTCVideoViewObjectFit
                                          .RTCVideoViewObjectFitCover,
                                ),

                                BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 8,
                                    sigmaY: 8,
                                  ),
                                  child: Container(
                                    color: Colors.black.withAlpha(100),
                                  ),
                                ),

                                Center(
                                  child: Text(
                                    state.stateText,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
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
                          _calllCubit.localRenderer,
                          mirror: true,
                          objectFit:
                              RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
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
                        color:
                            Theme.of(context).colorScheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Call ID: ${state.roomId}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),

              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(Icons.call_end, color: Colors.white),
                onPressed: () {
                  _calllCubit.hangup();
                  context.go('/');
                },
              ),
            );
          } else if (state is CallFailed) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(state.error),
                    SizedBox(height: 20),
                    FilledButton(onPressed: () {}, child: Text('Go Back')),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text('Call connecting...'),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
