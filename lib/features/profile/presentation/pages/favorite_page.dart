import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace with actual favorite product list
    final List favoriteProducts = [];

    return Scaffold(
      backgroundColor: const Color(0xFFFFFCFD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFCFD),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Color(0xFFFF79A2),
            size: 28,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Favorite',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2B2B2B),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF2B2B2B)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.shopping_bag_outlined,
              color: Color(0xFF2B2B2B),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: favoriteProducts.isEmpty
          ? const _FavoriteEmptyState()
          : _FavoriteGrid(products: favoriteProducts),
    );
  }
}

class _FavoriteEmptyState extends StatelessWidget {
  const _FavoriteEmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Pink shopping bag icon illustration
          SizedBox(
            width: 80,
            height: 80,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  size: 64,
                  color: const Color(0xFFFF79A2).withOpacity(0.35),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(
                    Icons.favorite,
                    size: 22,
                    color: const Color(0xFFFF79A2).withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Your favorite product is empty!',
            style: TextStyle(fontSize: 13, color: Color(0xFFFF79A2)),
          ),
        ],
      ),
    );
  }
}

class _FavoriteGrid extends StatelessWidget {
  final List products;
  const _FavoriteGrid({required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (_, i) {
        // Replace with your actual product card widget
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
            ],
          ),
          child: const Center(child: Text('Product')),
        );
      },
    );
  }
}
