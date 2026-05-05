import 'package:flutter/material.dart';
import 'package:flutter_product_detail_app/features/profile/presentation/widgets/profile_avatar.dart';

class ProfileHeaderBanner extends StatelessWidget {
  final String name;
  final String email;
  final String? avatarAsset;

  const ProfileHeaderBanner({
    super.key,
    required this.name,
    required this.email,
    this.avatarAsset, required ProfileAvatar avatarWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF79A2), Color(0xFFFF5C8E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              color: Colors.white,
            ),
            child: ClipOval(
              child: avatarAsset != null
                  ? Image.asset(avatarAsset!, fit: BoxFit.cover)
                  : Container(
                      color: const Color(0xFF2B2B2B),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
            ),
          ),

          const SizedBox(width: 16),

          // Name & Email
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: const TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ),

          // Edit button
          GestureDetector(
            onTap: () {
              // Navigate to edit profile
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.edit_outlined,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
