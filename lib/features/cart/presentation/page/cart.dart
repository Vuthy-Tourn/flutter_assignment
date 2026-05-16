import 'package:flutter/material.dart';

import '../../../../core/router/app_router.dart';
import '../widgets/cart_widget.dart';
import '../../../home/presentation/widgets/bottom_nav_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

/// ================= MODEL =================

class CartItemModel {
  final String name;
  final double price;
  final double oldPrice;
  final String image;

  int quantity;
  bool isSelected;

  CartItemModel({
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.image,
    this.quantity = 1,
    this.isSelected = true,
  });
}

/// ================= SCREEN =================

class _CartScreenState extends State<CartScreen> {
  int currentIndex = 1;

  final List<CartItemModel> items = [
    CartItemModel(
      name: 'Blush',
      price: 18.7,
      oldPrice: 70,
      image: 'assets/images/option2.png',
    ),
    CartItemModel(
      name: 'Sunscreen',
      price: 10,
      oldPrice: 70,
      image: 'assets/images/product_gallery_2.png',
    ),
  ];

  /// ================= GETTERS =================

  double get total => items
      .where((item) => item.isSelected)
      .fold(0, (sum, item) => sum + (item.price * item.quantity));

  int get selectedCount =>
      items.where((item) => item.isSelected).length;

  bool get isAllSelected =>
      items.isNotEmpty &&
          items.every((item) => item.isSelected);

  bool get hasSelectedItems => selectedCount > 0;

  /// ================= LOGIC =================

  void _toggleSelectAll(bool? value) {
    setState(() {
      for (final item in items) {
        item.isSelected = value ?? false;
      }
    });
  }

  void _removeSelectedItems() {
    setState(() {
      items.removeWhere((item) => item.isSelected);
    });
  }

  void _incrementQty(CartItemModel item) {
    setState(() => item.quantity++);
  }

  void _decrementQty(CartItemModel item) {
    if (item.quantity > 1) {
      setState(() => item.quantity--);
    }
  }

  void _toggleItemSelection(
      CartItemModel item,
      bool? value,
      ) {
    setState(() {
      item.isSelected = value ?? false;
    });
  }

  void _onNavTap(int index) {
    setState(() => currentIndex = index);

    switch (index) {
      case 0:
        Navigator.pushNamed(context, AppRouter.home);
        break;

      case 1:
        break;

      case 2:
        Navigator.pushNamed(context, AppRouter.order);
        break;

      case 3:
        Navigator.pushNamed(context, AppRouter.inbox);
        break;

      case 4:
        Navigator.pushNamed(context, AppRouter.profile);
        break;
    }
  }

  void _goToPayment() {
    final selectedItems = items
        .where((item) => item.isSelected)
        .map(
          (item) => {
        'name': item.name,
        'price': item.price,
        'qty': item.quantity,
        'image': item.image,
      },
    )
        .toList();

    Navigator.pushNamed(
      context,
      AppRouter.payment,
      arguments: selectedItems,
    );
  }

  /// ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: _buildAppBar(),

      body: Column(
        children: [
          SelectAllRow(
            isAllSelected: isAllSelected,
            onSelectAll: _toggleSelectAll,
            onDelete: _removeSelectedItems,
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: items.length,
              itemBuilder: (_, index) {
                final item = items[index];

                return CartItemCard(
                  title: item.name,
                  price: item.price,
                  oldPrice: item.oldPrice,
                  quantity: item.quantity,
                  isSelected: item.isSelected,
                  imagePath: item.image,

                  onIncrement: () => _incrementQty(item),

                  onDecrement: () => _decrementQty(item),

                  onToggleSelect: (value) =>
                      _toggleItemSelection(item, value),
                );
              },
            ),
          ),

          CheckoutSection(
            total: total,
            selectedCount: selectedCount,
            enabled: hasSelectedItems,
            onTap: _goToPayment,
          ),
        ],
      ),

      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: _onNavTap,
      ),
    );
  }

  /// ================= APP BAR =================

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,

      title: const Text(
        'Cart',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),

      actions: [
        IconButton(
          icon: const Icon(
            Icons.search_outlined,
            color: Colors.pinkAccent,
          ),
          onPressed: () {
            Navigator.pushNamed(context, AppRouter.search);
          },
        ),

        IconButton(
          icon: const Icon(
            Icons.notifications_none_outlined,
            color: Colors.pinkAccent,
          ),
          onPressed: () {
            Navigator.pushNamed(context, AppRouter.inbox);
          },
        ),

        const SizedBox(width: 8),
      ],
    );
  }
}

/// ================= SELECT ALL ROW =================

class SelectAllRow extends StatelessWidget {
  final bool isAllSelected;
  final ValueChanged<bool?> onSelectAll;
  final VoidCallback onDelete;

  const SelectAllRow({
    super.key,
    required this.isAllSelected,
    required this.onSelectAll,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          Checkbox(
            value: isAllSelected,
            activeColor: Colors.pinkAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            onChanged: onSelectAll,
          ),

          const Text(
            'Select all',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),

          const Spacer(),

          IconButton(
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.grey,
            ),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}

/// ================= CHECKOUT SECTION =================

class CheckoutSection extends StatelessWidget {
  final double total;
  final int selectedCount;
  final bool enabled;
  final VoidCallback onTap;

  const CheckoutSection({
    super.key,
    required this.total,
    required this.selectedCount,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 75,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: enabled
                ? const Color(0xFFFF2D6C)
                : Colors.grey[400],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Place order ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  Text(
                    '($selectedCount)',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),

              Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                crossAxisAlignment:
                CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Sub total',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    '\$ ${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}