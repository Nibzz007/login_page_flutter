import 'package:flutter/material.dart';
import 'package:login_sample/screens/splash.dart';

// ignore: constant_identifier_names
const  SAVE_KEY_NAME = 'userLogedIn';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Sample',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true
      ),
      home: const ScreenSplash(),
    );
  }
}