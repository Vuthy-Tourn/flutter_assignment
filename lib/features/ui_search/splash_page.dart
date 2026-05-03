import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_product_detail_app/features/Auth/presentation/pages/login_page.dart';
import 'package:flutter_product_detail_app/features/Auth/presentation/pages/sign_up_page.dart';
import 'package:flutter_product_detail_app/core/theme/app_colors.dart';

void main() {
  runApp(const EternalShineApp());
}

class EternalShineApp extends StatelessWidget {
  const EternalShineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eternal Shine',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: AppColors.primary,
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(),
    );
  }
}

class OnboardingItem {
  final String title;
  final String subtitle;
  final String image;
  final Color bgColor;

  OnboardingItem({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.bgColor,
  });
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _popAnimation;
  late Animation<Color?> _backgroundColorAnimation;
  late Animation<Color?> _logoColorAnimation;
  late Animation<Offset> _slideUpAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2500));
    _popAnimation = CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.5, curve: Curves.elasticOut));
    _backgroundColorAnimation = ColorTween(begin: AppColors.primary, end: Colors.white).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.4, 0.8, curve: Curves.easeInOut)));
    _logoColorAnimation = ColorTween(begin: Colors.white, end: AppColors.primary).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.4, 0.8, curve: Curves.easeInOut)));
    _slideUpAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(0, -0.6)).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.8, 1.0, curve: Curves.fastOutSlowIn)));

    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted) {
            Navigator.of(context).pushReplacement(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const OnboardingScreen(),
              transitionsBuilder: (context, anim, secondaryAnim, child) => FadeTransition(opacity: anim, child: child),
              transitionDuration: const Duration(milliseconds: 600),
            ));
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: _backgroundColorAnimation.value,
          body: Center(
            child: SlideTransition(
              position: _slideUpAnimation,
              child: ScaleTransition(
                scale: _popAnimation,
                child: Image.asset(
                  'assets/images/app_logo.png',
                  width: MediaQuery.of(context).size.width * 0.55,
                  color: _logoColorAnimation.value,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _entryController;
  late Animation<Offset> _logoSlideAnimation;

  final List<OnboardingItem> items = [
    OnboardingItem(
      title: "Your Personal Beauty Store",
      subtitle: "Shop top beauty products handpicked for your skin.\nSimple, smart, and tailored to you.",
      image: "assets/images/poster1.png",
      bgColor: Colors.transparent,
    ),
    OnboardingItem(
      title: "Tell Us About Your Skin",
      subtitle: "Answer a few questions for better recommendations.",
      image: "assets/images/poster2.png",
      bgColor: Colors.transparent,
    ),
    OnboardingItem(
      title: "Personalize Your Glow",
      subtitle: "Select concerns like acne or dryness.",
      image: "assets/images/poster3.png",
      bgColor: const Color(0xFFE8EDF9),
    ),
    OnboardingItem(
      title: "Let's Glow",
      subtitle: "Start your personalized skincare journey.",
      image: "assets/images/poster4.png",
      bgColor: Colors.transparent,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _entryController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _logoSlideAnimation = Tween<Offset>(begin: const Offset(0, -0.2), end: Offset.zero).animate(CurvedAnimation(parent: _entryController, curve: Curves.easeOut));
    _entryController.forward();
  }

  @override
  void dispose() {
    _entryController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. BACKGROUND LAYER - Poster 3 now uses BoxFit.cover to look better
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            child: Container(
              key: ValueKey('bg_img_$_currentPage'),
              decoration: BoxDecoration(
                color: items[_currentPage].bgColor,
                image: DecorationImage(
                  image: AssetImage(items[_currentPage].image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // 2. TEXT PROTECTION
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [
                  Colors.white.withValues(alpha: 0.4),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // 3. CONTENT
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 15),
                SlideTransition(
                  position: _logoSlideAnimation,
                  child: Image.asset(
                    'assets/images/app_logo.png',
                    height: 40,
                    color: AppColors.primary,
                    errorBuilder: (context, error, stackTrace) => Text(
                      "ETERNAL SHINE",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                        letterSpacing: 3,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) => setState(() => _currentPage = index),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            Text(
                              items[index].title.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A1A1A),
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              items[index].subtitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF1A1A1A).withValues(alpha: 0.7),
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // 4. BOTTOM CONTROLS
          Positioned(
            bottom: 40,
            left: 25,
            right: 25,
            child: _currentPage == items.length - 1 ? _buildAuthButtons() : _buildNavigation(),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => _pageController.jumpToPage(items.length - 1),
          child: Text(
            "Skip",
            style: TextStyle(
              color: Colors.black.withValues(alpha: 0.4),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(children: List.generate(items.length, (index) => _dot(index))),
        GestureDetector(
          onTap: () => _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10),
              ],
            ),
            child: const Icon(Icons.arrow_forward_rounded, color: Colors.black, size: 22),
          ),
        ),
      ],
    );
  }

  Widget _buildAuthButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage())),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.9),
              side: const BorderSide(color: Colors.transparent),
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            ),
            child: const Text("Login", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage())),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 20),
              elevation: 5,
              shadowColor: AppColors.primary.withOpacity(0.3),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            ),
            child: const Text("Sign Up", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _dot(int i) {
    bool isSelected = _currentPage == i;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.only(right: 6),
      width: isSelected ? 20 : 6,
      height: 4,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.black.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}