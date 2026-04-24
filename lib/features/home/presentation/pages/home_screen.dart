// Update your existing home_screen.dart

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/router/app_router.dart';
import '../../../../data/models/product_model.dart';
import '../widgets/home_category_grid.dart';
import '../widgets/section_header.dart';
import '../widgets/horizontal_product_list.dart';
import '../widgets/brand_chip.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/hero_carousel.dart';
import 'notification_screen.dart'; // 👈 Import notification page

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;
  final String _skinType = 'normal';

  List<ProductModel> get _recommended =>
      sampleProducts.where((p) => p.suitableFor.contains(_skinType)).toList();

  void _onNavTap(int index) {
    setState(() => _navIndex = index);

    switch (index) {
      case 0: // Home — already here
        break;
      case 1: // Cart
        // Navigator.pushNamed(context, AppRouter.cart);
        break;
      case 2: // Order
        // Navigator.pushNamed(context, AppRouter.order);
        break;
      case 3: // Inbox
        // Navigator.pushNamed(context, AppRouter.inbox);
        break;
      case 4: // Profile
        // Navigator.pushNamed(context, AppRouter.profile);
        break;
    }
  }

  // void _openNotifications() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => const NotificationPage(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final double systemBottom = MediaQuery.of(context).viewPadding.bottom;
    final double scrollBottomPadding = 72.0 + systemBottom + 12.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,

      // ── AppBar ───────────────────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: AppColors.border,
        centerTitle: true,
        title: Image.asset(
          'assets/images/app_logo.png',
          height: 34,
          errorBuilder: (context, error, stackTrace) => Text(
            'GlowUp',
            style: tt.titleLarge?.copyWith(color: AppColors.primary),
          ),
        ),
        actions: [
          NotificationIconButton(count: 4),
              
          IconButton(
            icon: const Icon(Icons.search_outlined),
            color: AppColors.secondary,
            onPressed: () => Navigator.pushNamed(context, AppRouter.cart),
          ),
        ],
      ),

      // ── Bottom nav ───────────────────────────────────────────────────────
      bottomNavigationBar: BottomNavBar(
        currentIndex: _navIndex,
        cartCount: 0,
        onTap: _onNavTap,
      ),

      // ── Body ─────────────────────────────────────────────────────────────
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: scrollBottomPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Hero carousel ──────────────────────────────────────────────
            const HeroCarousel(height: 200),

            // ── Category grid ──────────────────────────────────────────────
            const HomeCategoryGrid(),

            // ── Current Promotion ──────────────────────────────────────────
            SectionHeader(
              title: 'Current Promotion',
              onSeeAll: () => Navigator.pushNamed(context, AppRouter.search),
            ),
            HorizontalProductList(products: sampleProducts, listHeight: 320),

            // ── Best Deal ──────────────────────────────────────────────────
            SectionHeader(
              title: 'Best Deal',
              onSeeAll: () => Navigator.pushNamed(context, AppRouter.search),
            ),
            HorizontalProductList(
              products: sampleProducts,
              offset: 2,
              listHeight: 320,
            ),

            // ── Trending Now ───────────────────────────────────────────────
            SectionHeader(
              title: 'Trending Now',
              onSeeAll: () => Navigator.pushNamed(context, AppRouter.search),
            ),
            _recommended.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'No trending products for your skin type.',
                      style: tt.bodyMedium,
                    ),
                  )
                : HorizontalProductList(
                    products: _recommended,
                    listHeight: 320,
                  ),

            // ── Popular Brand ──────────────────────────────────────────────
            SectionHeader(title: 'Popular Brand'),
            BrandMarquee(images: brandList, speed: 55),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}