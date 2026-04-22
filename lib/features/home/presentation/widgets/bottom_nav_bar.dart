// lib/features/home/presentation/widgets/bottom_nav_bar.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const _NavItem(this.icon, this.activeIcon, this.label);
}

const _kItems = [
  _NavItem(Icons.home_outlined, Icons.home_rounded, 'Home'),
  _NavItem(Icons.shopping_cart_outlined, Icons.shopping_cart_rounded, 'Cart'),
  _NavItem(Icons.history_outlined, Icons.history_rounded, 'Order'),
  _NavItem(Icons.mail_outline_rounded, Icons.mail_rounded, 'Inbox'),
  _NavItem(Icons.person_outline_rounded, Icons.person_rounded, 'Profile'),
];

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final int cartCount;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.cartCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return ClipRect(
      clipBehavior: Clip.none,
      child: Container(
        width: double.infinity,
        // Shorter bar — only top border, zero shadow
        padding: EdgeInsets.fromLTRB(6, 4, 6, 4 + bottomInset),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.border, width: 1)),
          // No boxShadow at all
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(_kItems.length, (i) {
            return _NavTile(
              item: _kItems[i],
              isActive: currentIndex == i,
              badge: i == 1 && cartCount > 0 ? cartCount : null,
              onTap: () => onTap(i),
            );
          }),
        ),
      ),
    );
  }
}

class _NavTile extends StatefulWidget {
  final _NavItem item;
  final bool isActive;
  final int? badge;
  final VoidCallback onTap;

  const _NavTile({
    required this.item,
    required this.isActive,
    required this.onTap,
    this.badge,
  });

  @override
  State<_NavTile> createState() => _NavTileState();
}

class _NavTileState extends State<_NavTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
    if (widget.isActive) _ctrl.value = 1.0;
  }

  @override
  void didUpdateWidget(_NavTile old) {
    super.didUpdateWidget(old);
    if (widget.isActive && !old.isActive) _ctrl.forward(from: 0);
    if (!widget.isActive && old.isActive) _ctrl.reverse();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, _) {
          final double iconScale = _iconScaleFor(_ctrl.value);
          final double circleFill = Curves.easeOutCubic.transform(_ctrl.value);

          // Icon is white on top of the circle when active,
          // textSecondary when inactive (no circle)
          final Color iconColor = circleFill > 0
              ? Color.lerp(
                  AppColors.textSecondary,
                  AppColors.surface,
                  circleFill,
                )!
              : AppColors.textSecondary;

          return SizedBox(
            width: 56,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ── Icon — lifts only when active ─────────────────
                Transform.translate(
                  offset: Offset(0, -12 * circleFill),
                  child: Transform.scale(
                    scale: iconScale,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        // Circle ONLY rendered when animating/active
                        if (circleFill > 0)
                          Container(
                            width: 46,
                            height: 46,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary,
                              // No shadow
                            ),
                          ),

                        Icon(
                          widget.isActive
                              ? widget.item.activeIcon
                              : widget.item.icon,
                          size: 24,
                          color: iconColor,
                        ),

                        // Badge
                        if (widget.badge != null)
                          Positioned(
                            right: 4,
                            top: 4,
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              constraints: const BoxConstraints(
                                minWidth: 15,
                                minHeight: 15,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.accent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${widget.badge}',
                                style: tt.bodyMedium?.copyWith(
                                  color: AppColors.surface,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  height: 1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 2),

                // ── Label ─────────────────────────────────────────
                Text(
                  widget.item.label,
                  style: tt.bodyMedium?.copyWith(
                    color: widget.isActive
                        ? AppColors.primary
                        : AppColors.textSecondary,
                    fontWeight: widget.isActive
                        ? FontWeight.w700
                        : FontWeight.w400,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Peak 1.55 → settles at 1.12 when active
  static double _iconScaleFor(double t) {
    if (t <= 0.35) {
      final seg = t / 0.35;
      final eased = Curves.easeOut.transform(seg);
      return 1.0 + eased * 0.55;
    } else {
      final seg = (t - 0.35) / 0.65;
      final eased = Curves.elasticOut.transform(seg);
      return 1.55 - eased * 0.43;
    }
  }
}
