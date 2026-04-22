// lib/main.dart
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
      initialRoute: AppRouter.home,
      routes: {
        AppRouter.home: (_) => const HomeScreen(),

        // ProductDetailPage expects a ProductDetail object.
        // ProductCard currently passes a ProductModel (different type).
        // Until both models are unified, we use DemoProductDetail as the
        // data source so the page always opens correctly.
        // TODO: replace DemoProductDetail.product with a real lookup once
        //       ProductModel and ProductDetail are merged.
        AppRouter.productDetail: (_) =>
            ProductDetailPage(product: DemoProductDetail.product),
      },
    );
  }
}
