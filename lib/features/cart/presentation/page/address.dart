import 'package:flutter/material.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  static const Color primaryColor = Color(0xFFFF2D6C);
  static const Color dividerColor = Color(0xFFE5E5E5);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: AddressAppBar(),
      body: AddressPage(),
    );
  }
}

/// ================= APP BAR =================
class AddressAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AddressAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: AddressScreen.primaryColor,
          size: 22,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'My Address',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xFF161F30),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// ================= BODY =================
class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Divider(
          height: 1,
          thickness: 0.5,
          color: AddressScreen.dividerColor,
        ),

        AddressOptionTile(
          icon: Icons.my_location,
          title: 'Use Current Location (Using GPS)',
        ),

        Divider(
          height: 1,
          thickness: 0.5,
          indent: 16,
          color: AddressScreen.dividerColor,
        ),

        AddressOptionTile(
          icon: Icons.map_outlined,
          title: 'Choose map',
        ),

        Divider(
          height: 1,
          thickness: 0.5,
          color: AddressScreen.dividerColor,
        ),

        SectionTitle(title: 'Saved Location'),

        Expanded(
          child: EmptyAddressState(),
        ),
      ],
    );
  }
}

/// ================= OPTION TILE =================
class AddressOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const AddressOptionTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: AddressScreen.primaryColor,
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F222B),
                ),
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.black26,
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= SECTION TITLE =================
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        top: 40,
        bottom: 16,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

/// ================= EMPTY STATE =================
class EmptyAddressState extends StatelessWidget {
  const EmptyAddressState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.add_location_alt_outlined,
            size: 56,
            color: AddressScreen.primaryColor,
          ),

          SizedBox(height: 24),

          Text(
            'No location Address',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),

          SizedBox(height: 80),
        ],
      ),
    );
  }
}