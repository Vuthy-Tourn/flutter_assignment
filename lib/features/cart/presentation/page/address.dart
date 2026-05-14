import 'package:flutter/material.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF9FAFB), // soft background
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
        icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        "My Address",
        style: TextStyle(
          color: Color(0xFF1A1C1E),
          fontSize: 20,
          fontWeight: FontWeight.w700,
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
      children: const [
        SizedBox(height: 12),

        /// Card Container for Options
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: _OptionCard(),
        ),

        /// Section Title
        _SectionTitle(title: "Saved Location"),

        /// Empty State
        Expanded(child: _EmptyState()),
      ],
    );
  }
}

/// ---------------- OPTION CARD ----------------
class _OptionCard extends StatelessWidget {
  const _OptionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            color: Colors.black.withOpacity(0.04),
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: const [
          _LocationOption(
            icon: Icons.gps_fixed,
            title: "Use Current Location (GPS)",
          ),
          _Divider(indent: 60),
          _LocationOption(
            icon: Icons.map,
            title: "Choose map",
          ),
        ],
      ),
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
      borderRadius: BorderRadius.circular(16),
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Row(
          children: [
            /// Icon with background (modern style)
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFFF4081).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFFFF4081), size: 22),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1C1E),
                ),
              ),
            ),

            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

/// ---------------- DIVIDER ----------------
class _Divider extends StatelessWidget {
  final double indent;

  const _Divider({this.indent = 0});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 0.5,
      indent: indent,
    );
  }
}

/// ---------------- SECTION TITLE ----------------
class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 16, top: 28, bottom: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Saved Location",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
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
        children: [
          /// Modern icon style
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFFF4081).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.location_off,
              size: 48,
              color: Color(0xFFFF4081),
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            "No saved address",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            "Add a new address to make checkout easier",
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}