import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class HomeCategoryGrid extends StatelessWidget {
  const HomeCategoryGrid({super.key});

  static const List<_HomeCategoryItem> _items = [
    _HomeCategoryItem('Best Deal', Icons.spa_outlined),
    _HomeCategoryItem('New Arrivals', Icons.shopping_bag_outlined),
    _HomeCategoryItem('Clearance Sale', Icons.local_offer_outlined),
    _HomeCategoryItem('Time Deal', Icons.watch_later_outlined),
    _HomeCategoryItem('Skincare', Icons.face_retouching_natural_outlined),
    _HomeCategoryItem('Make Up', Icons.brush_outlined),
    _HomeCategoryItem('Supplement', Icons.favorite_border),
    _HomeCategoryItem('Beauty Tools', Icons.auto_fix_high_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Outer horizontal padding so icons align with the rest of the page content
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisExtent: 92,
          crossAxisSpacing: 8, // tightened so 4 columns breathe evenly
          mainAxisSpacing: 14,
        ),
        itemBuilder: (context, index) {
          final item = _items[index];
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 241, 181, 199),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(item.icon, color: AppColors.primary, size: 28),
              ),
              const SizedBox(height: 6),
              Text(
                item.label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                  fontSize:
                      10, // keeps long labels like "Clearance Sale" on 2 lines
                  height: 1.3,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _HomeCategoryItem {
  const _HomeCategoryItem(this.label, this.icon);
  final String label;
  final IconData icon;
}
