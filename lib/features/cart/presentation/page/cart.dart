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

  // ── LOGIC (រក្សាទុកទម្រង់ដើម) ───────────────────────────

  double get total => items
      .where((e) => e['selected'] == true)
      .fold(0, (sum, e) => sum + (e['price'] * e['qty']));

  int get selectedCount => items.where((e) => e['selected'] == true).length;

  bool get isAllSelected => items.every((e) => e['selected'] == true);

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
      backgroundColor: Colors.white, // ប្តូរជាពណ៌សដើម្បីឱ្យស៊ីជាមួយ Design ថ្មី
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
            icon: const Icon(Icons.search_outlined, color: Colors.pinkAccent),
            onPressed: () => Navigator.pushNamed(context, AppRouter.search),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined,
                color: Colors.pinkAccent),
            onPressed: () => Navigator.pushNamed(context, AppRouter.inbox),
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  onIncrement: () => setState(() => item['qty']++),
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

          /// 💳 ផ្នែកដែលបាន DESIGN ថ្មីតាមរូបភាព image_85e178.png
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Checkbox(
            value: isAllSelected,
            activeColor: Colors.pinkAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            onChanged: _toggleSelectAll,
          ),
          const Text(
            "Select all",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.grey),
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

  /// 💳 BOTTOM CHECKOUT (Design Updated to match image_85e178.png)
  Widget _buildBottomCheckout() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
      child: InkWell(
        onTap: hasSelectedItems ? _goToPayment : null,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          height: 75,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: hasSelectedItems ? const Color(0xFFFF2D6C) : Colors.grey[400],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ផ្នែកអក្សរខាងឆ្វេង: Place order (2)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Place order ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "($selectedCount)",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),

              // ផ្នែកតម្លៃខាងស្តាំ: Sub total / $ 28.70
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "Sub total",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "\$ ${total.toStringAsFixed(2)}",
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