import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Widget? trailing;
  final Color? labelColor;
  final Color? iconColor;
  final bool showArrow;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
    this.labelColor,
    this.iconColor,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color resolvedIconColor = iconColor ?? const Color(0xFFFF79A2);
    final Color resolvedLabelColor = labelColor ?? const Color(0xFF2B2B2B);

    return InkWell(
      onTap: onTap,
      splashColor: const Color(0xFFFFE4EC),
      highlightColor: const Color(0xFFFFE4EC).withOpacity(0.4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: resolvedIconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20, color: resolvedIconColor),
            ),

            const SizedBox(width: 16),

            // Label
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: resolvedLabelColor,
                ),
              ),
            ),

            // Trailing widget or arrow
            if (trailing != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  trailing!,
                  if (showArrow) ...[
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: Color(0xFF7D7D7D),
                    ),
                  ],
                ],
              )
            else if (showArrow)
              const Icon(
                Icons.chevron_right,
                size: 20,
                color: Color(0xFF7D7D7D),
              ),
          ],
        ),
      ),
    );
  }
}
