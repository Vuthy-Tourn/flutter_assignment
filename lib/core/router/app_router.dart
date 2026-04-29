// lib/core/router/app_router.dart
//
// One constant per destination.
// Dynamic pages (CategoryPage, ProductDetailPage) share a single route and
// receive their data via Navigator arguments — not via separate route strings.
//
// Pattern:
//   Navigator.pushNamed(context, AppRouter.category, arguments: 'Skincare')
//   Navigator.pushNamed(context, AppRouter.productDetail, arguments: product)

class AppRouter {
  AppRouter._();

  // ── Auth ──────────────────────────────────────────────────────────────
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signUp = '/sign-up';

  // ── Main navigation ───────────────────────────────────────────────────
  static const String home = '/';
  static const String search = '/search';
  static const String cart = '/cart';
  static const String inbox = '/inbox';
  static const String profile = '/profile';

  // ── Product ───────────────────────────────────────────────────────────
  static const String productDetail = '/product-detail';
  static const String order = '/order';

  // ── Category ──────────────────────────────────────────────────────────
  // ONE route for all categories. Pass the display name as arguments:
  //   Navigator.pushNamed(context, AppRouter.category, arguments: 'Skincare')
  static const String category = '/category';
  // ── Cart ──────────────────────────────────────────────────────────
  // The Router for check payment products
  static const String payment = '/payment';
}
