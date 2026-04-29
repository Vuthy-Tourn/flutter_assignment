import 'package:flutter/material.dart';
import 'package:flutter_product_detail_app/features/home/presentation/pages/notification_screen.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/product_model.dart';
import '../widgets/home_category_grid.dart';
import '../widgets/section_header.dart';
import '../widgets/horizontal_product_list.dart';
import '../widgets/brand_chip.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/hero_carousel.dart';
import '../../../order_page/presentation/pages/order_page.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,

      // ================= BODY (PAGE SWITCHING) =================
      body: IndexedStack(
        index: _navIndex,
        children: [
          _buildHomePage(tt), // 0 = Home
          const _CartPage(), // 1 = Cart (placeholder)
          const OrderPage(), // 2 = Order
          const _InboxPage(), // 3 = Inbox (placeholder)
          const _ProfilePage(), // 4 = Profile (placeholder)
        ],
      ),
      // ================= BOTTOM NAV =================
      bottomNavigationBar: BottomNavBar(
        currentIndex: _navIndex,
        // cartCount: 2,
        onTap: _onNavTap,
      ),
    );
  }

  // ================= HOME CONTENT =================
  Widget _buildHomePage(TextTheme tt) {
    final double systemBottom = MediaQuery.of(context).viewPadding.bottom;
    final double scrollBottomPadding = 72.0 + systemBottom + 12.0;

    return Scaffold(
      backgroundColor: AppColors.background,

      // ── AppBar ─────────────────────────────────────
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
            onPressed: () => Navigator.pushNamed(context, AppRouter.search),
          ),
        ],
      ),

      // ── Body ───────────────────────────────────────
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: scrollBottomPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeroCarousel(height: 200),

            const HomeCategoryGrid(),

            SectionHeader(title: 'Current Promotion', onSeeAll: () {}),
            HorizontalProductList(products: sampleProducts, listHeight: 320),

            SectionHeader(title: 'Best Deal', onSeeAll: () {}),
            HorizontalProductList(
              products: sampleProducts,
              offset: 2,
              listHeight: 320,
            ),

            SectionHeader(title: 'Trending Now', onSeeAll: () {}),
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

            SectionHeader(title: 'Popular Brand'),
            BrandMarquee(images: brandList, speed: 55),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ================= PLACEHOLDER PAGES =================

class _CartPage extends StatelessWidget {
  const _CartPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Cart Page")));
  }
}

class _InboxPage extends StatelessWidget {
  const _InboxPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Inbox Page")));
  }
}

class _ProfilePage extends StatelessWidget {
  const _ProfilePage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Profile Page")));
  }
}
