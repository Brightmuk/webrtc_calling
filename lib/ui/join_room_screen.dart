import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webrtc_tutorial/signaling.dart';

class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  Signaling signaling = Signaling.instance;
  TextEditingController textEditingController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Join Room', style: Theme.of(context).textTheme.headlineMedium),
          TextFormField(controller: textEditingController),
          SizedBox(height: 8),
          Expanded(child: Container()),
          FilledButton(
            onPressed: () {
              signaling.joinRoom(textEditingController.text.trim());
              context.go('/call', extra: textEditingController.text.trim());
            },
            child: Text('Join Room'),
          ),
        ],
      ),
    );
  }
}
