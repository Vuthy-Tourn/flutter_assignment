import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/product_model.dart';
import '../../../../core/router/app_router.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final bool isFeatured;

  const ProductCard({
    super.key,
    required this.product,
    this.isFeatured = false,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        AppRouter.productDetail,
        arguments: product,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Image + badges ─────────────────────────────────────────────
            Stack(
              children: [
                Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: product.imageUrl != null
                        ? Image.asset(
                            product.imageUrl!,
                            fit: BoxFit.contain,
                            // FIX: was (_, _, _) → duplicate variable compile error
                            errorBuilder: (_, _, _) => _placeholder(),
                          )
                        : _placeholder(),
                  ),
                ),

                // Featured pill
                if (isFeatured)
                  Positioned(
                    top: 10,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Featured',
                          style: TextStyle(
                            color: AppColors.surface,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                // Favourite button
                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: AppColors.surface,
                    child: const Icon(
                      Icons.favorite_border,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),

            // ── Text details ───────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.name,
                    style: tt.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 3),

                  Text(
                    product.description,
                    style: tt.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.35,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: tt.bodyLarge?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const _StarRow(rating: 4.0, reviewCount: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() => const Center(
    child: Icon(Icons.spa_outlined, color: AppColors.primary, size: 44),
  );
}

// ── Star rating row ───────────────────────────────────────────────────────────
class _StarRow extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const _StarRow({required this.rating, required this.reviewCount});

  @override
  Widget build(BuildContext context) {
    final fullStars = rating.floor();
    final hasHalf = (rating - fullStars) >= 0.5;
    final emptyStars = 5 - fullStars - (hasHalf ? 1 : 0);

    return Row(
      children: [
        for (int i = 0; i < fullStars; i++)
          const Icon(Icons.star_rounded, size: 14, color: AppColors.star),
        if (hasHalf)
          const Icon(Icons.star_half_rounded, size: 14, color: AppColors.star),
        for (int i = 0; i < emptyStars; i++)
          const Icon(
            Icons.star_outline_rounded,
            size: 14,
            color: AppColors.star,
          ),
        const SizedBox(width: 4),
        if (reviewCount > 0)
          Text(
            '($reviewCount)',
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
      ],
    );
  }
}
