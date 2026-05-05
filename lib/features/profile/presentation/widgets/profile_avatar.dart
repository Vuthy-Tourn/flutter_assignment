import 'package:flutter/material.dart';
import '../../../../data/models/profile_data.dart'; // adjust path

/// Reusable avatar widget that reads [ProfileData.avatarBytes].
/// Set [size] for the circle diameter.
/// Set [showEditBadge] to overlay the pink pencil button.
/// Set [onEditTap] to handle the badge tap (e.g. open image picker).
class ProfileAvatar extends StatelessWidget {
  final double size;
  final bool showEditBadge;
  final VoidCallback? onEditTap;

  const ProfileAvatar({
    super.key,
    this.size = 72,
    this.showEditBadge = false,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ProfileData.instance,
      builder: (_, _) {
        final bytes = ProfileData.instance.avatarBytes;
        final avatar = Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFFF79A2), width: 2),
            color: const Color(0xFF2B2B2B),
          ),
          child: ClipOval(
            child: bytes != null
                ? Image.memory(bytes, fit: BoxFit.cover)
                : Container(
                    color: const Color(0xFF2B2B2B),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: size * 0.55,
                    ),
                  ),
          ),
        );

        if (!showEditBadge) return avatar;

        final badgeSize = size * 0.30;
        return Stack(
          children: [
            avatar,
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: onEditTap,
                child: Container(
                  width: badgeSize,
                  height: badgeSize,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF79A2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: badgeSize * 0.55,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
