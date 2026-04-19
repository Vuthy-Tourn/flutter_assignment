import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class ProductDetailAppBar extends StatelessWidget {
  const ProductDetailAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          ),
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/images/app_logo.png',
                height: 90,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 44),
        ],
      ),
    );
  }
}
