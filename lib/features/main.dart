import 'package:flutter/material.dart';
import 'package:flutter_product_detail_app/features/product_detail/presentation/auth/login_page.dart';
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