import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'data/demo/demo_product_detail.dart';

// Import your page files
import 'features/home/presentation/pages/home_screen.dart';
import 'features/home/presentation/pages/category_page.dart';
import 'features/product_detail/presentation/pages/product_detail_page.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/ui_search/splash_page.dart';

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

      // 1. Start the app at the Splash Screen
      initialRoute: AppRouter.splash,

      routes: {
        // 2. Map Splash to your SplashScreen class
        AppRouter.splash: (_) => const SplashScreen(),

        // 3. Map Onboarding (Ensure this class exists in splash_page.dart)
        AppRouter.onboarding: (_) => const OnboardingScreen(),

        // 4. Map Login and Home
        AppRouter.login: (_) => const LoginPage(),
        AppRouter.home: (_) => const HomeScreen(),

        // 5. Map remaining routes
        AppRouter.category: (_) => const CategoryPage(),
        AppRouter.productDetail: (_) =>
            ProductDetailPage(product: DemoProductDetail.product),
      },
    );
  }
}