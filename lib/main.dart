import 'package:flutter/material.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'data/demo/demo_product_detail.dart';
import 'features/cart/presentation/page/payment.dart';
import 'features/home/presentation/pages/category_page.dart';
import 'features/home/presentation/pages/home_screen.dart';
import 'features/order_page/presentation/pages/order_page.dart';
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
      initialRoute: AppRouter.login,
      routes: {
        // AppRouter.login: (_) => const LoginPage(),
        AppRouter.home: (_) => const HomeScreen(),
        AppRouter.payment: (_) => const PaymentPage(),

        // One route handles every category.
        // The label string is passed as arguments from HomeCategoryGrid.
        // CategoryPage reads it with ModalRoute.of(context)?.settings.arguments
        AppRouter.category: (_) => const CategoryPage(),

        // ProductDetailPage always uses demo data until models are unified.
        AppRouter.productDetail: (_) =>
            ProductDetailPage(product: DemoProductDetail.product),
        AppRouter.order: (_) => const OrderPage(),
      },
    );
  }
}