import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
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
          FilledButton(onPressed: () async {
            await getPermissions();
             String roomId = await signaling.createRoom();
             context.push('/call', extra: roomId);
          }, child: Text('Create a Room')),
          SizedBox(height: 20),
          OutlinedButton(
            onPressed: () async {
              await getPermissions();
             context.push('/join');
            },
            child: Text('Join Room'),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
  Future<void> getPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
  Permission.camera,
  Permission.microphone,
].request();
    print(statuses);
    if (statuses[Permission.camera]!.isGranted && statuses[Permission.microphone]!.isGranted) {
      print('Camera and Microphone permissions are granted');
    } else {
      print('Camera and/or Microphone permissions are denied'); 
  }}
}
