import 'package:flutter/material.dart';
import 'login_page.dart'; // This connects to the code you just shared

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eternal Shine',
      // We use a simple theme for now to avoid the network/font crash
      theme: ThemeData(
        primarySwatch: Colors.pink,
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}