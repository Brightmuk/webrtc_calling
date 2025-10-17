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
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
           
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter Room ID',
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              controller: textEditingController,
            ),
            SizedBox(height: 8),
            Expanded(child: Container()),
            FilledButton(
              onPressed: () {
                signaling.joinRoom(textEditingController.text.trim());
                context.push('/call', extra: textEditingController.text.trim());
              },
              child: Text('Join Room'),
            ),
          ],
        ),
      ),
    );
  }
}
