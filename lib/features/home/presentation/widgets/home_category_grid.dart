import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class HomeCategoryGrid extends StatelessWidget {
  const HomeCategoryGrid({super.key});
  

static const List<_HomeCategoryItem> _items = [
    _HomeCategoryItem('Best Deal', 'assets/images/categories/beauty 1.png'),
    _HomeCategoryItem(
      'New Arrivals',
      'assets/images/categories/day-cream 1.png',
    ),
    _HomeCategoryItem(
      'Clearance Sale',
      'assets/images/categories/essential-oil (2) 1.png',
    ),
    _HomeCategoryItem('Time Deal', 'assets/images/categories/gel 1.png'),
    _HomeCategoryItem('Skincare', 'assets/images/categories/serum (1) 1.png'),
    _HomeCategoryItem('Make Up', 'assets/images/categories/makeup 1.png'),
    _HomeCategoryItem(
      'Supplement',
      'assets/images/categories/beauty-treatment (2) 1.png',
    ),
    _HomeCategoryItem(
      'Beauty Tools',
      'assets/images/categories/nail-polish (2) 1.png',
    ),
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
          mainAxisExtent: 82,
          mainAxisSpacing: 10,
          
        ),
        padding: EdgeInsets.fromLTRB(5, 12, 5, 4),
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
child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(item.image, fit: BoxFit.contain),
                ),              ),
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
  const _HomeCategoryItem(this.label, this.image);
  final String label;
  final String image;
}
