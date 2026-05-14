// lib/main.dart
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'data/demo/demo_product_detail.dart';

import 'features/home/presentation/pages/home_screen.dart';
import 'features/home/presentation/pages/category_page.dart';
import 'features/cart/presentation/page/cart.dart';
import 'features/product_detail/presentation/pages/product_detail_page.dart';
import 'features/cart/presentation/page/payment.dart';
import 'features/cart/presentation/page/address.dart';

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

      // Keep your table if you prefer it simple
      routes: {
        AppRouter.home: (_) => const HomeScreen(),
        AppRouter.cart: (_) => const CartScreen(),
        AppRouter.category: (_) => const CategoryPage(),
        AppRouter.productDetail: (_) => ProductDetailPage(product: DemoProductDetail.product),
        AppRouter.payment: (_) => const PaymentPage(), // This will now receive arguments correctly
        AppRouter.address: (_) => const AddressScreen(),
      },
    );
  }
}