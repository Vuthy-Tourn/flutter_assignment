// lib/features/home/presentation/widgets/product_card.dart

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/product_model.dart';
import '../../../../core/router/app_router.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  /// Show the pink "Featured" pill badge over the image.
  /// Wire this to product.isFeatured once the model has it.
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
        // ✅ No fixed height — let content dictate size.
        //    The previous Column overflow came from cramming dynamic text
        //    into a height that was too short.
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          // ✅ Removed hard border; subtle shadow matches the screenshot style.
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // ✅ shrink-wraps — prevents overflow
          children: [

            // ── Image + Featured badge ─────────────────────────────────────
            Stack(
              children: [
                // Image area
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
                      fit: BoxFit.contain, // contain keeps product centred
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
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF4081), // hot-pink
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Featured',
                          style: TextStyle(
                            color: Colors.white,
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
                    child: Icon(
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

                  // Product name
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

                  // Description / type — 2 lines like the screenshot
                  Text(
                    product.description ,
                    style: tt.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.35,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  // Price
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: tt.bodyLarge?.copyWith(
                      color: AppColors.textPrimary, // dark, not primary pink
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Star rating row
                  _StarRow(
                    // rating: product.rating ?? 4.0,
                    // reviewCount: product.reviewCount ?? 10,
                    rating: 4.0,
                    reviewCount: 10,
                  ),

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
    final fullStars  = rating.floor();
    final hasHalf    = (rating - fullStars) >= 0.5;
    final emptyStars = 5 - fullStars - (hasHalf ? 1 : 0);

    return Row(
      children: [
        // Filled stars
        for (int i = 0; i < fullStars; i++)
          const Icon(Icons.star_rounded, size: 14, color: Color(0xFFFFC107)),
        // Half star
        if (hasHalf)
          const Icon(Icons.star_half_rounded, size: 14, color: Color(0xFFFFC107)),
        // Empty stars
        for (int i = 0; i < emptyStars; i++)
          const Icon(Icons.star_outline_rounded,
              size: 14, color: Color(0xFFFFC107)),

        const SizedBox(width: 4),

        if (reviewCount > 0)
          Text(
            '($reviewCount)',
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF9E9E9E),
            ),
          ),
      ],
    );
  }
}