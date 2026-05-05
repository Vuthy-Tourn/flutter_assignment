import 'package:flutter/material.dart';
import '../../../../data/models/profile_data.dart';
import '../widgets/profile_avatar.dart';
import 'edit_profile_page.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFCFD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFCFD),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Color(0xFFFF79A2),
            size: 28,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2B2B2B),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EditProfilePage()),
            ),
            child: const Text(
              'Edit',
              style: TextStyle(
                color: Color(0xFFFF79A2),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: ProfileData.instance,
        builder: (context, _) {
          final p = ProfileData.instance;
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // ── Avatar (read-only view, no edit badge) ─────────────
                const Center(child: ProfileAvatar(size: 72)),

                const SizedBox(height: 28),

                _ProfileInfoRow(label: 'First Name', value: p.firstName),
                _ProfileInfoRow(label: 'Last Name', value: p.lastName),
                _ProfileInfoRow(label: 'Gender', value: p.gender),
                _PhoneInfoRow(value: p.phone),
                _ProfileInfoRow(label: 'Email', value: p.email),
                _ProfileInfoRow(label: 'Birthday', value: p.birthday),

                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ── Private row widgets ───────────────────────────────────────────────────────

class _ProfileInfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _ProfileInfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 14, color: Color(0xFF7D7D7D)),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2B2B2B),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 1,
          color: Color(0xFFF2E9ED),
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }
}

class _PhoneInfoRow extends StatelessWidget {
  final String value;
  const _PhoneInfoRow({required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              const Text('🇰🇭', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2B2B2B),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 1,
          color: Color(0xFFF2E9ED),
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }
}
