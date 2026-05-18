import 'package:flutter/material.dart';

import '../../../../core/router/app_router.dart';

import '../widgets/keyboard_widget.dart';
import '../widgets/QR_widget.dart';

import 'Branch_Screen.dart';
import 'Vocher.dart';
import 'delivery_screen.dart';
import 'success.dart';
import 'up_date.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

/// ================= CONSTANTS =================

class PaymentColors {
  static const primary = Color(0xFFFF2D6C);
  static const khqrRed = Color(0xFFD50000);
}

/// ================= SCREEN =================

class _PaymentPageState extends State<PaymentPage> {
  String noteText = '';
  String selectedDeliveryMethod = 'Delivery Method';
  String selectedBranch = 'Choose Branches';
  String selectedPickUpTime = 'Pick Up Time';

  bool isDeliverySelected = true;
  bool isKHQRSelected = false;

  /// ================= GETTERS =================

  List<Map<String, dynamic>> get items {
    final raw = ModalRoute.of(context)?.settings.arguments;

    return raw != null
        ? List<Map<String, dynamic>>.from(raw as List)
        : [];
  }

  double get subtotal => items.fold(
    0,
        (sum, item) =>
    sum +
        ((item['price'] ?? 0) *
            (item['qty'] ?? 1)),
  );

  double get discount => 6.20;

  double get deliveryFee =>
      isDeliverySelected ? 1.0 : 0.0;

  double get total =>
      subtotal - discount + deliveryFee;

  /// ================= LOGIC =================

  void _toggleDelivery(bool value) {
    setState(() {
      isDeliverySelected = value;
    });
  }

  void _showCustomKeyboard() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return KeyboardWidget(
          onKeyTap: (value) {
            setState(() => noteText += value);
          },

          onDelete: () {
            if (noteText.isNotEmpty) {
              setState(() {
                noteText = noteText.substring(
                  0,
                  noteText.length - 1,
                );
              });
            }
          },

          onDone: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  Future<void> _selectDeliveryMethod() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const DeliveryScreen(),
      ),
    );

    if (result != null && result is String) {
      setState(() {
        selectedDeliveryMethod = result;
      });
    }
  }

  void _selectBranch() {
    BranchScreen.showBranchOptions(
      context,
          (branch) {
        setState(() {
          selectedBranch = branch;
        });
      },
    );
  }

  void _selectPickUpTime() {
    UpDate.showPicker(
      context,
          (date, time) {
        setState(() {
          selectedPickUpTime =
          '${date.day}/${date.month}/${date.year} $time';
        });
      },
    );
  }

  void _showQRModal() {
    setState(() => isKHQRSelected = true);

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black87,
      transitionDuration:
      const Duration(milliseconds: 300),

      pageBuilder: (_, __, ___) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),

              child: Container(
                color: Colors.transparent,

                child: Center(
                  child: GestureDetector(
                    onTap: () {},

                    child: Container(
                      margin:
                      const EdgeInsets.symmetric(
                        horizontal: 40,
                      ),

                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(20),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),

                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(20),

                        child: QRWidget(
                          qrData:
                          'https://pay.khqr.com/eternal_shine_demo',
                          merchantName:
                          'ETERNAL SHINE',
                          amount: total,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },

      transitionBuilder:
          (_, animation, __, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutBack,
          ),
          child: child,
        );
      },
    );
  }

  void _goToSuccessPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SuccessPage(
          totalAmount: total,
        ),
      ),
    );
  }

  /// ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: _buildAppBar(),

      bottomNavigationBar:
      _buildBottomPayButton(),

      body: SingleChildScrollView(
        padding:
        const EdgeInsets.only(bottom: 40),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [
            const SizedBox(height: 20),

            _buildToggle(),

            const SizedBox(height: 25),

            if (isDeliverySelected) ...[
              PaymentTile(
                icon: Icons.map_outlined,
                title: 'Address',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRouter.address,
                  );
                },
              ),

              PaymentTile(
                icon:
                Icons.local_shipping_outlined,
                title: selectedDeliveryMethod,
                onTap:
                _selectDeliveryMethod,
              ),
            ] else ...[
              PaymentTile(
                icon: Icons.store_outlined,
                title: selectedBranch,
                onTap: _selectBranch,
              ),

              PaymentTile(
                icon:
                Icons.access_time_outlined,
                title: selectedPickUpTime,
                onTap: _selectPickUpTime,
              ),
            ],

            PaymentTile(
              icon:
              Icons.confirmation_number_outlined,
              title: 'Apply Voucher',
              onTap: () => Voucher.show(
                context,
              ),
            ),

            const SizedBox(height: 25),

            _buildNoteBox(),

            const SizedBox(height: 25),

            const Padding(
              padding:
              EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                'Order Summary',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight:
                  FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 12),

            ...items.map(_buildItemCard),

            const SizedBox(height: 25),

            const Padding(
              padding:
              EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                'PAYMENT DETAILS',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight:
                  FontWeight.w800,
                ),
              ),
            ),

            PaymentSummary(
              subtotal: subtotal,
              discount: discount,
              deliveryFee: deliveryFee,
              total: total,
            ),

            KHQRSection(
              isSelected: isKHQRSelected,
              onTap: _showQRModal,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// ================= APP BAR =================

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,

      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Colors.black54,
        ),
        onPressed: () => Navigator.pop(context),
      ),

      title: const Text(
        'Payment',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// ================= TOGGLE =================

  Widget _buildToggle() {
    return Padding(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 20,
      ),

      child: Row(
        children: [
          ToggleButton(
            label: 'Delivery',
            isActive:
            isDeliverySelected,
            onTap: () =>
                _toggleDelivery(true),
          ),

          const SizedBox(width: 15),

          ToggleButton(
            label: 'Pick Up',
            isActive:
            !isDeliverySelected,
            onTap: () =>
                _toggleDelivery(false),
          ),
        ],
      ),
    );
  }

  /// ================= NOTE =================

  Widget _buildNoteBox() {
    return Padding(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 20,
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [
          const Text(
            'Note',
            style: TextStyle(
              color: Color(0xFF3F51B5),
              fontSize: 14,
              fontWeight:
              FontWeight.w500,
            ),
          ),

          const SizedBox(height: 8),

          GestureDetector(
            onTap: _showCustomKeyboard,

            child: Container(
              height: 120,
              width: double.infinity,
              padding:
              const EdgeInsets.all(15),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(
                  15,
                ),
                border: Border.all(
                  color:
                  Colors.grey.shade300,
                ),
              ),

              child: Text(
                noteText.isEmpty
                    ? 'Enter note'
                    : noteText,

                style: TextStyle(
                  fontSize: 14,
                  color: noteText.isEmpty
                      ? Colors.grey.shade400
                      : Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= ITEM CARD =================

  Widget _buildItemCard(
      Map<String, dynamic> item,
      ) {
    return Container(
      margin:
      const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),

      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [
          ClipRRect(
            borderRadius:
            BorderRadius.circular(10),

            child: Image.asset(
              item['image'] ?? '',
              width: 85,
              height: 85,
              fit: BoxFit.cover,

              errorBuilder:
                  (_, __, ___) {
                return Container(
                  width: 85,
                  height: 85,
                  color:
                  Colors.pink.shade50,
                  child: const Icon(
                    Icons.image,
                    color: Colors.pink,
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                Text(
                  item['name'] ?? '',
                  style:
                  const TextStyle(
                    fontSize: 16,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                const Text(
                  'Creates vivid face with gorgeous co...',
                  maxLines: 1,
                  overflow:
                  TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),

                const Text(
                  '57.00 USD',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    decoration:
                    TextDecoration
                        .lineThrough,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  '\$${(item['price'] ?? 0).toStringAsFixed(2).replaceAll('.00', '')}',
                  style: const TextStyle(
                    color:
                    PaymentColors.primary,
                    fontWeight:
                    FontWeight.w900,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding:
            const EdgeInsets.only(
              top: 25,
            ),

            child: Text(
              'x${item['qty'] ?? 1}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= PAY BUTTON =================

  Widget _buildBottomPayButton() {
    return Container(
      color: Colors.white,

      padding:
      const EdgeInsets.fromLTRB(
        20,
        10,
        20,
        30,
      ),

      child: SizedBox(
        height: 55,
        width: double.infinity,

        child: ElevatedButton(
          onPressed:
          isKHQRSelected
              ? _goToSuccessPage
              : null,

          style:
          ElevatedButton.styleFrom(
            elevation: 0,

            backgroundColor:
            isKHQRSelected
                ? PaymentColors
                .primary
                : Colors
                .grey.shade300,

            shape:
            RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(
                12,
              ),
            ),
          ),

          child: const Text(
            'PAY NOW',
            style: TextStyle(
              fontSize: 18,
              fontWeight:
              FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

/// ================= TOGGLE BUTTON =================

class ToggleButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const ToggleButton({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,

        child: Container(
          height: 45,
          alignment: Alignment.center,

          decoration: BoxDecoration(
            color: isActive
                ? PaymentColors.primary
                : const Color(0xFFC4C4C4),

            borderRadius:
            BorderRadius.circular(
              25,
            ),
          ),

          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight:
              FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

/// ================= PAYMENT TILE =================

class PaymentTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const PaymentTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        height: 65,

        margin:
        const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 6,
        ),

        padding:
        const EdgeInsets.symmetric(
          horizontal: 15,
        ),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(15),

          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),

        child: Row(
          children: [
            Container(
              padding:
              const EdgeInsets.all(8),

              decoration:
              const BoxDecoration(
                color: Color(0xFFF1F5F9),
                shape: BoxShape.circle,
              ),

              child: Icon(
                icon,
                size: 22,
                color: Colors.black87,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight:
                  FontWeight.w500,
                ),
              ),
            ),

            const Icon(
              Icons.chevron_right,
              size: 22,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= PAYMENT SUMMARY =================

class PaymentSummary extends StatelessWidget {
  final double subtotal;
  final double discount;
  final double deliveryFee;
  final double total;

  const PaymentSummary({
    super.key,
    required this.subtotal,
    required this.discount,
    required this.deliveryFee,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),

      child: Column(
        children: [
          _row(
            'Sub total',
            '\$ ${subtotal.toStringAsFixed(2)}',
          ),

          _row(
            'Discount',
            '-\$ ${discount.toStringAsFixed(2)}',
            color:
            Colors.pinkAccent.shade100,
          ),

          _row(
            'Birthday Discount',
            '-\$ 0.00',
            color: Colors.lightGreen,
          ),

          _row(
            'Member Discount(0.0%)',
            '-\$ 0.00',
          ),

          _row(
            'Delivery Fee',
            '\$ ${deliveryFee.toInt()}',
          ),

          Padding(
            padding:
            const EdgeInsets.symmetric(
              vertical: 15,
            ),

            child: Row(
              children: List.generate(
                40,
                    (index) => Expanded(
                  child: Container(
                    height: 2,
                    color:
                    index.isEven
                        ? Colors
                        .transparent
                        : Colors.grey
                        .shade200,
                  ),
                ),
              ),
            ),
          ),

          _row(
            'TOTAL',
            '\$ ${total.toStringAsFixed(2)}',
            isBold: true,
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _row(
      String title,
      String value, {
        Color? color,
        bool isBold = false,
      }) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(
        vertical: 5,
      ),

      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,

        children: [
          Text(
            title,
            style: TextStyle(
              fontSize:
              isBold ? 18 : 14,
              fontWeight:
              isBold
                  ? FontWeight.w900
                  : FontWeight.w500,
            ),
          ),

          Text(
            value,
            style: TextStyle(
              fontSize:
              isBold ? 16 : 14,
              fontWeight:
              isBold
                  ? FontWeight.w900
                  : FontWeight.w500,
              color:
              color ?? Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= KHQR SECTION =================

class KHQRSection extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const KHQRSection({
    super.key,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        margin:
        const EdgeInsets.symmetric(
          horizontal: 20,
        ),

        padding: const EdgeInsets.all(15),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(15),

          border: Border.all(
            color:
            isSelected
                ? PaymentColors.primary
                : Colors.grey.shade200,
          ),
        ),

        child: Row(
          children: [
            Container(
              width: 35,
              height: 35,

              alignment: Alignment.center,

              decoration: BoxDecoration(
                color:
                PaymentColors.khqrRed,
                borderRadius:
                BorderRadius.circular(
                  6,
                ),
              ),

              child: const Text(
                'KHQR',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 7,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 12),

            const Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment
                    .start,

                children: [
                  Text(
                    'ABA KHQR',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  Text(
                    'Scan to pay with any banking app',
                    style: TextStyle(
                      color:
                      Colors.blueAccent,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right,
              size: 22,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
