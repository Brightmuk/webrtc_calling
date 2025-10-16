import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webrtc_tutorial/signaling.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Signaling signaling = Signaling.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text(
            'Welcome \nto the Calling App',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            'Start calling your friends now',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Expanded(child: Container()),
          FilledButton(onPressed: ()async {
             String roomId = await signaling.createRoom();
             context.go('/call', extra: roomId);
          }, child: Text('Create a Room')),
          SizedBox(height: 20),
          OutlinedButton(
            onPressed: ()  {
             context.push('/join');
            },
            child: Text('Join Room'),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
