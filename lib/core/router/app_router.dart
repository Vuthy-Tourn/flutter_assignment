class AppRouter {
  AppRouter._();

  // ── Auth ─────────────────────────────────────────
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signUp = '/sign-up';

  // ── Main navigation ──────────────────────────────
  static const String home = '/';
  static const String search = '/search';
  static const String cart = '/cart';
  static const String inbox = '/inbox';
  static const String profile = '/profile';

  // ── Product ──────────────────────────────────────
  static const String productDetail = '/product-detail';
  static const String order = '/order';

  // ── Category ─────────────────────────────────────
  static const String category = '/category';

  // ── Payment ──────────────────────────────────────
  static const String payment = '/payment';
}