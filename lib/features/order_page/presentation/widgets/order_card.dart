// lib/features/order_page/presentation/widgets/order_card.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../pages/order_page.dart';

class OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderCard({super.key, required this.order});

  Color _statusColor(OrderFilter status) {
    switch (status) {
      case OrderFilter.processing:
        return const Color(0xFFFFA726); // amber
      case OrderFilter.orderFailed:
        return AppColors.primary;
      case OrderFilter.successful:
        return const Color(0xFF66BB6A); // green
      case OrderFilter.all:
        return AppColors.textSecondary;
    }
  }

  String _statusLabel(OrderFilter status) {
    switch (status) {
      case OrderFilter.processing:
        return 'Processing';
      case OrderFilter.orderFailed:
        return 'Order Failed';
      case OrderFilter.successful:
        return 'Delivered';
      case OrderFilter.all:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final OrderFilter status = order['status'] as OrderFilter;
    final bool hasDeliveryBadge = order['hasDeliveryBadge'] as bool;
    final double price = order['price'] as double;
    final int quantity = order['quantity'] as int;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Product image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    order['image'] as String,
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.shopping_bag_outlined,
                        color: AppColors.primary,
                        size: 28,
                      ),
                    ),
                  ),
                ),
                // Delivery badge (green dot for delivered)
                if (hasDeliveryBadge)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xFF66BB6A),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(width: 12),

            // Product info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: _statusColor(status),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      _statusLabel(status),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: _statusColor(status),
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    order['name'] as String,
                    style: tt.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  Text(
                    order['description'] as String,
                    style: tt.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Text(
                    order['brand'] as String,
                    style: tt.labelSmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 10,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      Text(
                        '\$${price.toStringAsFixed(price % 1 == 0 ? 0 : 2)}',
                        style: tt.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Quantity badge
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                'x$quantity',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
