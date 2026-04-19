import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'data/demo/demo_product_detail.dart';
import 'features/product_detail/presentation/pages/product_detail_page.dart';

void main() {
  runApp(const ProductDetailApp());
}

class ProductDetailApp extends StatelessWidget {
  const ProductDetailApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eternal Shine',
      theme: AppTheme.lightTheme,
      home: ProductDetailPage(product: DemoProductDetail.product),
    );
  }
}
