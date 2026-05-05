import 'package:flutter/material.dart';
import 'package:flutter_product_detail_app/features/order_page/presentation/pages/order_page.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/profile_data.dart';
import '../widgets/header_banner.dart';
import '../widgets/menu_item.dart';
import '../widgets/profile_modals.dart';
import '../widgets/section_title.dart';
import '../widgets/profile_avatar.dart';
import 'about.dart';
import 'my_account_page.dart';
import 'address_page.dart';
import 'favorite_page.dart';
import 'privacy_policy_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFCFD),

      // ── AppBar — matches HomeScreen exactly ───────────────────────────
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
      ),

      // ── Body ──────────────────────────────────────────────────────────
      body: ListenableBuilder(
        listenable: ProfileData.instance,
        builder: (context, _) {
          final profile = ProfileData.instance;
          final double navBarPadding =
              72.0 + MediaQuery.of(context).viewPadding.bottom + 12.0;

          return SingleChildScrollView(
            padding: EdgeInsets.only(bottom: navBarPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Pink banner with live avatar ───────────────────────
                ProfileHeaderBanner(
                  name: profile.fullName,
                  email: profile.email,
                  avatarAsset: null,
                  avatarWidget: const ProfileAvatar(size: 64),
                ),

                const SizedBox(height: 24),

                // ── Personal ──────────────────────────────────────────
                const ProfileSectionTitle(title: 'Personal'),
                const SizedBox(height: 4),

                ProfileMenuItem(
                  icon: Icons.person_outline,
                  label: 'My Account',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MyAccountPage()),
                  ),
                ),
                ProfileMenuItem(
                  icon: Icons.location_on_outlined,
                  label: 'Address',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddressPage()),
                  ),
                ),
                ProfileMenuItem(
                  icon: Icons.favorite_border,
                  label: 'Favorite',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FavoritePage()),
                  ),
                ),
                ProfileMenuItem(
                  icon: Icons.notifications_none_outlined,
                  label: 'Notification',
                  onTap: () {},
                ),
                ProfileMenuItem(
                  icon: Icons.receipt_long_outlined,
                  label: 'My Order',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const OrderPage()),
                  ),
                ),

                const SizedBox(height: 24),

                // ── Setting ────────────────────────────────────────────
                const ProfileSectionTitle(title: 'Setting'),
                const SizedBox(height: 4),

                ProfileMenuItem(
                  icon: Icons.shield_outlined,
                  label: 'Privacy Policy',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PrivacyPolicyPage(),
                    ),
                  ),
                ),
                ProfileMenuItem(
                  icon: Icons.info_outline,
                  label: 'About us',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AboutUsPage()),
                  ),
                ),
                ProfileMenuItem(
                  icon: Icons.headset_mic_outlined,
                  label: 'Customer Service',
                  onTap: () => showCustomerServiceModal(context),
                ),
                ProfileMenuItem(
                  icon: Icons.language_outlined,
                  label: 'Language',
                  trailing: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('🇬🇧', style: TextStyle(fontSize: 18)),
                      SizedBox(width: 6),
                      Text(
                        'English',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF7D7D7D),
                        ),
                      ),
                    ],
                  ),
                  onTap: () => showLanguageModal(context),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(color: Color(0xFFF2E9ED), thickness: 1),
                ),

                ProfileMenuItem(
                  icon: Icons.logout,
                  label: 'Logout',
                  labelColor: const Color(0xFFFF2160),
                  iconColor: const Color(0xFFFF2160),
                  showArrow: false,
                  onTap: () => showLogoutModal(
                    context,
                    onConfirm: () => Navigator.of(
                      context,
                    ).pushNamedAndRemoveUntil('/login', (_) => false),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }
}
