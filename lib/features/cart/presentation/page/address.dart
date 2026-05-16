import 'package:flutter/material.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white, // Pure white background matching the UI
      appBar: _AddressAppBar(),
      body: AddressPage(),
    );
  }
}

/// ---------------- APP BAR ----------------
class _AddressAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AddressAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        // Pink chevron-left icon matching UI
        icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFFF2D6C), size: 24),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        "My Address",
        style: TextStyle(
          color: Color(0xFF161F30),
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// ---------------- BODY ----------------
class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        // Top full-width divider under App Bar
        Divider(height: 1, thickness: 0.5, color: Color(0xFFE5E5E5)),

        /// List of Options (Plain flat list style, not a card)
        _LocationOption(
          icon: Icons.my_location, // Targeted GPS/Location style icon
          title: "Use Current Location (Using GPS)",
        ),
        Divider(height: 1, thickness: 0.5, color: Color(0xFFE5E5E5), indent: 16),

        _LocationOption(
          icon: Icons.map_outlined, // Map outline icon
          title: "Choose map",
        ),
        Divider(height: 1, thickness: 0.5, color: Color(0xFFE5E5E5)),

        /// Section Title
        _SectionTitle(title: "Saved Location"),

        /// Empty State Section
        Expanded(child: _EmptyState()),
      ],
    );
  }
}

/// ---------------- LOCATION OPTION ----------------
class _LocationOption extends StatelessWidget {
  final IconData icon;
  final String title;

  const _LocationOption({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Row(
          children: [
            // Standard crisp icon styling directly on text track
            Icon(icon, color: const Color(0xFFFF2D6C), size: 24),

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

            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black26),
          ],
        ),
      ),
    );
  }
}

/// ---------------- SECTION TITLE ----------------
class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 40, bottom: 16),
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

/// ---------------- EMPTY STATE ----------------
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          // Pin outline marker with a center question mark icon
          Icon(
            Icons.add_location_alt_outlined,
            size: 56,
            color: Color(0xFFFF2D6C),
          ),

          SizedBox(height: 24),

          Text(
            "No location Address",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),

          // Added spacing underneath to organically push the group slightly upwards
          SizedBox(height: 80),
        ],
      ),
    );
  }
}