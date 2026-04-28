// lib/features/order_page/presentation/pages/order_page.dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/order_filter_tabs.dart';
import '../widgets/order_card.dart';
import '../widgets/empty_order_state.dart';

enum OrderFilter { all, processing, orderFailed, successful }

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  OrderFilter _selectedFilter = OrderFilter.all;

  // Demo order data
  final List<Map<String, dynamic>> _allOrders = [
    {
      'id': 'ORD-001',
      'status': OrderFilter.processing,
      'name': 'Blush',
      'description': 'Creates vivid face with gorgeous co...',
      'brand': 'Innisfree',
      'price': 18.70,
      'quantity': 2,
      'image': 'assets/images/option1',
      'hasDeliveryBadge': false,
    },
    {
      'id': 'ORD-002',
      'status': OrderFilter.processing,
      'name': 'Sunscreen',
      'description': 'Creates vivid face with gorgeous co...',
      'brand': 'Innisfree',
      'price': 10.00,
      'quantity': 1,
      'image': 'assets/images/sunscreen_yellow.png',
      'hasDeliveryBadge': false,
    },
    {
      'id': 'ORD-003',
      'status': OrderFilter.successful,
      'name': 'Sunscreen',
      'description': 'Creates vivid face with gorgeous co...',
      'brand': 'Innisfree',
      'price': 10.00,
      'quantity': 2,
      'image': 'assets/images/sunscreen_pink.png',
      'hasDeliveryBadge': true,
    },
  ];

  List<Map<String, dynamic>> get _filteredOrders {
    if (_selectedFilter == OrderFilter.all) return _allOrders;
    return _allOrders
        .where((o) => o['status'] == _selectedFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final filtered = _filteredOrders;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: AppColors.border,
        centerTitle: true,
        title: Image.asset(
          'assets/images/app_logo.png',
          height: 34,
          errorBuilder: (_, __, ___) => Text(
            'Eternal\nShine',
            textAlign: TextAlign.center,
            style: tt.titleSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              height: 1.1,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            color: AppColors.secondary,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined),
            color: AppColors.secondary,
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'My Order',
              style: tt.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // Filter tabs
          OrderFilterTabs(
            selected: _selectedFilter,
            onSelected: (f) => setState(() => _selectedFilter = f),
          ),

          const SizedBox(height: 8),

          // Order list or empty state
          Expanded(
            child: filtered.isEmpty
                ? const EmptyOrderState()
                : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final order = filtered[index];
                return OrderCard(order: order);
              },
            ),
          ),
        ],
      ),
    );
  }
}
