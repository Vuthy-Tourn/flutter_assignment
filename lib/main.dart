import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'dart:async';
=======
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'data/demo/demo_product_detail.dart';
import 'features/cart/presentation/page/payment.dart';
import 'features/home/presentation/pages/category_page.dart';
import 'features/home/presentation/pages/home_screen.dart';
import 'features/order_page/presentation/pages/order_page.dart';
import 'features/product_detail/presentation/pages/product_detail_page.dart';
>>>>>>> Houy

void main() {
  runApp(const EternalShineApp());
}

class EternalShineApp extends StatelessWidget {
  const EternalShineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eternal Shine',
<<<<<<< HEAD
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const SplashScreen(),
    );
  }
}

// ==========================================
// 1. SPLASH PAGE
// ==========================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFED83A1),
      body: Center(
        child: Column( // Removed 'const' from here
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            // Ensure this file exists in your assets/images folder!
            Image.asset(
              'assets/images/app_logo.png',
              height: 100,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Text('Logo Placeholder', style: TextStyle(color: Colors.white));
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 2. ONBOARDING SCREEN
// ==========================================
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  // Make sure these filenames match your actual uploaded files
  final List<Map<String, String>> onboardingData = [
    {
      "title": "Your Personal Beauty Store",
      "subtitle": "Shop top beauty products handpicked for your skin.",
      "image": "assets/images/image_8b2150.jpg"
    },
    {
      "title": "Tell Us About Your Skin",
      "subtitle": "Answer a few quick questions for perfect recommendations.",
      "image": "assets/images/image_8b2131.jpg"
    },
    {
      "title": "Personalize Your Glow",
      "subtitle": "Select your concerns for more accurate matches.",
      "image": "assets/images/image_8b2112.jpg"
    },
    {
      "title": "Let's Glow",
      "subtitle": "Start browsing personalized picks and glow effortlessly.",
      "image": "assets/images/image_8b20f5.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F0F8),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Eternal\nShine',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFED83A1),
                  height: 1.0,
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  return OnboardingContent(
                    title: onboardingData[index]["title"]!,
                    subtitle: onboardingData[index]["subtitle"]!,
                    image: onboardingData[index]["image"]!,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: _currentPage == onboardingData.length - 1
                  ? _buildAuthButtons()
                  : _buildNavigationControls(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            if (_currentPage == 0) {
              _pageController.jumpToPage(onboardingData.length - 1);
            } else {
              _pageController.previousPage(
                  duration: const Duration(milliseconds: 300), curve: Curves.ease);
            }
          },
          child: const Text("Skip", style: TextStyle(color: Colors.grey, fontSize: 16)),
        ),
        Row(
          children: List.generate(
            onboardingData.length,
                (index) => buildDot(index: index),
          ),
        ),
        GestureDetector(
          onTap: () {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
          child: Container(
            height: 50, width: 50,
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _buildAuthButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
            child: const Text('Login'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFED83A1), foregroundColor: Colors.white),
            child: const Text('Sign up'),
          ),
        ),
      ],
    );
  }

  Widget buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? const Color(0xFFED83A1) : Colors.grey.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

// ==========================================
// 3. ONBOARDING CONTENT
// ==========================================
class OnboardingContent extends StatelessWidget {
  final String title, subtitle, image;
  const OnboardingContent({super.key, required this.title, required this.subtitle, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: [
              Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ),
        const Spacer(),
        Expanded(
          flex: 6,
          child: Image.asset(
            image,
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) => Center(child: Text("Missing: $image")),
          ),
        ),
      ],
    );
  }
=======
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
>>>>>>> Houy
}