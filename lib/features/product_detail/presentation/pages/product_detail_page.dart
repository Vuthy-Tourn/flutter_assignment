import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/product_detail.dart';
import '../widgets/product_detail_app_bar.dart';
import '../widgets/product_gallery.dart';
import '../widgets/product_information_section.dart';
import '../widgets/product_promo_banner.dart';
import '../widgets/product_summary_section.dart';
import '../widgets/product_tab_bar.dart';
import '../widgets/related_products_section.dart';
import '../widgets/review_card.dart';
import '../widgets/review_summary_card.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key, required this.product});

  final ProductDetail product;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _detailSectionKey = GlobalKey();
  final GlobalKey _reviewSectionKey = GlobalKey();

  ProductPageSection _selectedSection = ProductPageSection.detail;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _jumpToSection(ProductPageSection section) async {
    setState(() => _selectedSection = section);
    final key = section == ProductPageSection.detail
        ? _detailSectionKey
        : _reviewSectionKey;

    final context = key.currentContext;
    if (context != null) {
      await Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFFEFF), AppColors.background],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProductDetailAppBar(),
                ProductGallery(images: product.galleryImages),
                const SizedBox(height: 28),
                ProductSummarySection(product: product),
                const SizedBox(height: 30),
                ProductTabBar(
                  selectedSection: _selectedSection,
                  reviewCount: product.reviewCount,
                  onSectionSelected: _jumpToSection,
                ),
                Container(
                  key: _detailSectionKey,
                  margin: const EdgeInsets.only(top: 6),
                  child: ProductInformationSection(product: product),
                ),
                const ProductPromoBanner(),
                RelatedProductsSection(products: product.relatedProducts),
                Container(
                  key: _reviewSectionKey,
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                  child: Text(
                    'Review(${product.reviews.length})',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium?.copyWith(fontSize: 24),
                  ),
                ),
                ReviewSummaryCard(
                  rating: product.rating,
                  reviewCount: product.reviews.length,
                ),
                ...product.reviews.map((review) => ReviewCard(review: review)),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
