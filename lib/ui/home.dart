import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webrtc_tutorial/core/theme.dart';
import 'package:webrtc_tutorial/services/signaling_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Uri _url = Uri.parse('https://brimukon.com/privacy.html');
  SignalingService signaling = SignalingService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor,
      appBar: AppBar(
        backgroundColor: themeColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Image.asset('assets/images/icon_plain.png',width: 50,),
            SizedBox(height: 10),
            Text(
              'Instant video calls',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.bold,color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            Text(
              '✓ Make free secure video calls. \n✓ No sign-ups needed. \n✓ No data collected',
              style: TextStyle(color: Colors.white,fontSize: 16),
            ),
            Expanded(child: Container()),
            FilledButton(
              onPressed: () async {
              await getPermissions();
               context.push('/call');
            }, child: Text('Start a call')),
            SizedBox(height: 20),
            OutlinedButton(
              onPressed: () async {
                await getPermissions();
               context.push('/join');
              },
              child: Text('Join a call'),
            ),
            SizedBox(height: 20),
            TextButton(onPressed: _launchUrl, child: Text('Terms of service',style: TextStyle(color: Colors.white),)),
            SizedBox(height: 20),
          ],
        ),
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
  Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
    }
  }
}
