import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webrtc_tutorial/ui/call/call_screen.dart';
import 'package:webrtc_tutorial/ui/home.dart';
import 'package:webrtc_tutorial/ui/join_room_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
   navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/join',
      builder: (context, state) => JoinRoomScreen(),
    ),
    GoRoute(
      path: '/call',
      builder: (context, state) => CallScreen(roomId: state.extra as String? ),
    ),
  ],
);