import 'dart:io';
import 'package:appnew/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyDTBk4TuY8U_Y2qeURMuRi4FrHKqTQZjAo",
              appId: "1:318717995201:android:60365f6ab29dd4bc0d0c40",
              messagingSenderId: "318717995201",
              projectId: "garbageapp-d7963",
              storageBucket: "gs://garbageapp-d7963.appspot.com"),
        )
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Email and Password Login',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginScreen(),
    );
  }
}
