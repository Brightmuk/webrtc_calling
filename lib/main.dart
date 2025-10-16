import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:webrtc_tutorial/router.dart';
import 'package:webrtc_tutorial/core/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBRLeV1QupJw84CNZO9paM9dTuLymGjsTY",
      appId: "1:285473983255:android:431a09e2fc4abce2ec4552",
      messagingSenderId: "285473983255",
      projectId: "webrtc-27c8a",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Calling App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
