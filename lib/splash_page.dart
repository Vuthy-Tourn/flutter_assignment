import 'package:flutter/material.dart';
import 'dart:async';

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
      ),
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
    // Navigate to Onboarding after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFED83A1), // Pink color from your screenshot
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Eternal\nShine',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.0,
              ),
            ),
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

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Your Personal Beauty Store",
      "subtitle": "Shop top beauty products handpicked for your skin. Simple, smart, and tailored to you.",
      "image": "assets/images/onboarding1.png"
    },
    {
      "title": "Tell Us About Your Skin",
      "subtitle": "Answer a few quick questions so we can recommend the perfect products for your needs.",
      "image": "assets/images/onboarding2.png"
    },
    {
      "title": "Personalize Your Glow",
      "subtitle": "Select your concerns—like acne, dryness, or dullness—for more accurate product matches.",
      "image": "assets/images/onboarding3.png"
    },
    {
      "title": "Let's Glow",
      "subtitle": "Start browsing personalized picks, build your routine, and glow effortlessly.",
      "image": "assets/images/onboarding4.png"
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
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
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
          child: Text(
            _currentPage == 0 ? "Skip" : "Back",
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          children: List.generate(
            onboardingData.length,
                (index) => buildDot(index: index),
          ),
        ),
        GestureDetector(
          onTap: () { // FIXED: changed from onPressed to onTap
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
          child: Container(
            height: 50,
            width: 50,
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
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 0,
            ),
            child: const Text('Login', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFED83A1),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 0,
            ),
            child: const Text('Sign up', style: TextStyle(fontWeight: FontWeight.bold)),
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
        // FIXED: changed withOpacity to withValues
        color: _currentPage == index ? Colors.white : Colors.white.withValues(alpha: 0.5),
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
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF331B1B)),
              ),
              const SizedBox(height: 12),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Color(0xFF5B4A4A)),
              ),
            ],
          ),
        ),
        const Spacer(),
        Expanded(
          flex: 4,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              // FIXED: changed withOpacity to withValues
              color: Colors.grey.withValues(alpha: 0.2),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Center(child: Text("Image Placeholder: $image")),
          ),
        ),
      ],
    );
  }
}