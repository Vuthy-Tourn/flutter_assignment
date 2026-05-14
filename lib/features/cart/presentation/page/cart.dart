import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/cart_widget.dart';
import '../../../home/presentation/widgets/bottom_nav_bar.dart';
import '../../../../core/router/app_router.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int currentIndex = 1;

  final List<Map<String, dynamic>> items = [
    {
      'name': 'Blush',
      'price': 18.7,
      'oldPrice': 70.0,
      'qty': 1,
      'selected': true,
      'image': 'assets/images/option2.png',
    },
    {
      'name': 'Sunscreen',
      'price': 10.0,
      'oldPrice': 70.0,
      'qty': 1,
      'selected': true,
      'image': 'assets/images/product_gallery_2.png',
    },
  ];

  // ── LOGIC ─────────────────────────────────────────────

  double get total => items
      .where((e) => e['selected'] == true)
      .fold(0, (sum, e) => sum + (e['price'] * e['qty']));

  int get selectedCount =>
      items.where((e) => e['selected'] == true).length;

  bool get isAllSelected =>
      items.every((e) => e['selected'] == true);

  bool get hasSelectedItems => selectedCount > 0;

  void _toggleSelectAll(bool? val) {
    setState(() {
      for (var item in items) {
        item['selected'] = val ?? false;
      }
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

  // ── UI ─────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      /// 🔝 APP BAR (UPDATED)
      appBar: AppBar(
        title: const Text(
          "Cart",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined,
                color: AppColors.secondary),
            onPressed: () =>
                Navigator.pushNamed(context, AppRouter.inbox),
          ),
          IconButton(
            icon: const Icon(Icons.search_outlined,
                color: AppColors.secondary),
            onPressed: () =>
                Navigator.pushNamed(context, AppRouter.search),
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: Column(
        children: [
          _buildSelectAllRow(),

          /// 🛒 CART LIST
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, index) {
                final item = items[index];

                return CartItemCard(
                  title: item['name'],
                  price: item['price'],
                  oldPrice: item['oldPrice'],
                  quantity: item['qty'],
                  isSelected: item['selected'],
                  imagePath: item['image'],
                  onIncrement: () =>
                      setState(() => item['qty']++),
                  onDecrement: () {
                    if (item['qty'] > 1) {
                      setState(() => item['qty']--);
                    }
                  },
                  onToggleSelect: (val) {
                    setState(() {
                      item['selected'] = val ?? false;
                    });
                  },
                );
              },
            ),
          ),

          _buildBottomCheckout(),
        ],
      ),

      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: _onNavTap,
      ),
    );
  }

  /// 🔘 SELECT ALL ROW
  Widget _buildSelectAllRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Checkbox(
            value: isAllSelected,
            activeColor: Colors.pink,
            onChanged: _toggleSelectAll,
          ),
          const Text("Select all"),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              setState(() {
                items.removeWhere((e) => e['selected'] == true);
              });
            },
          ),
        ],
      ),
    );
  }

  /// 💳 BOTTOM CHECKOUT
  Widget _buildBottomCheckout() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: hasSelectedItems ? _goToPayment : null,
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: hasSelectedItems
                      ? Colors.pink
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Place order ($selectedCount)",
                  style: TextStyle(
                    color: hasSelectedItems
                        ? Colors.white
                        : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text("Sub total",
                  style: TextStyle(color: Colors.grey)),
              Text(
                "\$${total.toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _goToPayment() {
    final selectedItems = items
        .where((e) => e['selected'] == true)
        .map((e) => {
      'name': e['name'],
      'price': e['price'],
      'qty': e['qty'],
      'image': e['image'],
    })
        .toList();

    Navigator.pushNamed(
      context,
      AppRouter.payment,
      arguments: selectedItems,
    );
  }
}