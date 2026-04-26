// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_product_detail_app/features/cart/presentation/page/cart.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'data/demo/demo_product_detail.dart';
import 'features/home/presentation/pages/home_screen.dart';
import 'features/home/presentation/pages/category_page.dart';
import 'features/product_detail/presentation/pages/product_detail_page.dart';
import 'package:flutter_product_detail_app/features/cart/presentation/page/payment.dart';
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
        AppRouter.cart: (_) => const CartScreen(),


        // One route handles every category.
        // The label string is passed as arguments from HomeCategoryGrid.
        // CategoryPage reads it with ModalRoute.of(context)?.settings.arguments
        AppRouter.category: (_) => const CategoryPage(),

        // ProductDetailPage always uses demo data until models are unified.
        AppRouter.productDetail: (_) =>
            ProductDetailPage(product: DemoProductDetail.product),
        AppRouter.payment: (_) => const PaymentPage(),
      },
    );
  }
}
