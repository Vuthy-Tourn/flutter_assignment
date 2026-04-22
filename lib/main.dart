import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'data/demo/demo_product_detail.dart';
import 'features/home/presentation/pages/home_screen.dart';
import 'features/product_detail/presentation/pages/product_detail_page.dart';

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
      theme: AppTheme.lightTheme,

      // ── Initial route ────────────────────────────────────────
      initialRoute: AppRouter.home,

      // ── Named routes ─────────────────────────────────────────
      routes: {
        AppRouter.home: (_) => const HomeScreen(),
        AppRouter.productDetail: (context) {
          final product = ModalRoute.of(context)!.settings.arguments
          as dynamic ?? DemoProductDetail.product;
          return ProductDetailPage(product: product);
        },
      },
    );
  }
}