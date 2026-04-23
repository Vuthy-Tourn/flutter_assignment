import 'package:flutter/material.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/product_model.dart';
import '../../../../data/constants/category_constants.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/product_card.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _navIndex = 0;
  String _selectedFilter = 'All';

  List<String> _filtersFor(String title) =>
      kCategoryFilters[title] ?? kDefaultFilters;

  List<ProductModel> _filteredProducts(String filter) {
    switch (filter) {
      case 'Price: Low':
      case 'Under \$10':
        return [...sampleProducts]..sort((a, b) => a.price.compareTo(b.price));
      case 'Price: High':
        return [...sampleProducts]..sort((a, b) => b.price.compareTo(a.price));
      default:
        return sampleProducts;
    }
  }

  int? _discountFor(String categoryTitle) {
    if (kFilterDiscounts.containsKey(_selectedFilter)) {
      return kFilterDiscounts[_selectedFilter];
    }
    if (kCategoryDiscounts.containsKey(categoryTitle)) {
      return kCategoryDiscounts[categoryTitle];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final title    = ModalRoute.of(context)?.settings.arguments as String? ?? '';
    final filters  = _filtersFor(title);

    if (!filters.contains(_selectedFilter)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _selectedFilter = 'All');
      });
    }

    final products = _filteredProducts(_selectedFilter);
    final discount = _discountFor(title);

    final double systemBottom        = MediaQuery.of(context).viewPadding.bottom;
    final double scrollBottomPadding = 72.0 + systemBottom + 12.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: AppColors.border,
        centerTitle: true,
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          color: AppColors.textSecondary,
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            color: AppColors.textSecondary,
            onPressed: () => Navigator.pushNamed(context, AppRouter.cart),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined),
            color: AppColors.textSecondary,
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
      ),
      body: Column(
        children: [
          // ── Filter chips ──────────────────────────────────────
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: filters.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final filter     = filters[index];
                final isSelected = _selectedFilter == filter;
                return GestureDetector(
                  onTap: () => setState(() => _selectedFilter = filter),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.border,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      filter,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isSelected ? AppColors.surface : AppColors.textPrimary,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const Divider(height: 1, color: AppColors.border),

          // ── Product grid ──────────────────────────────────────
          Expanded(
            child: products.isEmpty
                ? Center(
              child: Text(
                'No products found.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            )
                : GridView.builder(
              padding: EdgeInsets.fromLTRB(16, 16, 16, scrollBottomPadding),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.62,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) => ProductCard(
                product: products[index],
                discountPercent: discount,
                isNewArrival: title == 'New Arrivals',
              ),
            ),
          ),
        ],
      ),
    );
  }
}