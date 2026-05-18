import 'package:flutter/material.dart';
import '../widgets/QR_widget.dart';
import 'delivery_screen.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

/// ================= CONSTANTS =================

class PaymentColors {
  static const primary = Color(0xFFFF2D6C);
  static const darkPrimary = Color(0xFF8E1439);
  static const khqrRed = Color(0xFFD00000);
}

/// ================= SCREEN =================

class _PaymentPageState extends State<PaymentPage> {
  String noteText = '';
  String selectedDeliveryMethod =
      'Delivery Method';

  /// ================= GETTERS =================

  List<Map<String, dynamic>> get items {
    final raw =
        ModalRoute.of(context)?.settings.arguments;

    return raw != null
        ? List<Map<String, dynamic>>.from(
      raw as List,
    )
        : [];
  }

  double get subtotal {
    return items.fold(
      0,
          (sum, item) =>
      sum +
          ((item['price'] ?? 0) *
              (item['qty'] ?? 1)),
    );
  }

  double get discount => 6.20;

  double get deliveryFee => 1.00;

  double get total =>
      subtotal - discount + deliveryFee;

  /// ================= LOGIC =================

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

  void _showPaymentModal() {
    FocusScope.of(context).unfocus();

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black54,
      transitionDuration:
      const Duration(milliseconds: 200),

      pageBuilder: (_, __, ___) {
        return Scaffold(
          backgroundColor: Colors.transparent,

          body: Center(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 24,
              ),

              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,

                children: [
                  QRWidget(
                    qrData:
                    'Your_KHQR_String_Payload',
                    merchantName:
                    'Eternal Shine',
                    amount: total,
                  ),

                  const SizedBox(height: 24),

                  const ModalABACard(),

                  const SizedBox(height: 16),

                  ModalPayButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  const SizedBox(height: 20),

                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    child: const Text(
                      'CLOSE',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: _buildAppBar(),

      body: SingleChildScrollView(
        padding:
        const EdgeInsets.only(bottom: 120),

        child: Column(
          children: [
            PaymentActionTile(
              icon:
              Icons.local_shipping_outlined,
              title:
              selectedDeliveryMethod,
              onTap:
              _selectDeliveryMethod,
            ),

            PaymentSummary(
              subtotal: subtotal,
              discount: discount,
              total: total,
            ),

            const ABATile(),
          ],
        ),
      ),

      bottomNavigationBar:
      MainPayButton(
        total: total,
        onTap: _showPaymentModal,
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
        'Payment',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

/// ================= MAIN PAY BUTTON =================

class MainPayButton extends StatelessWidget {
  final double total;
  final VoidCallback onTap;

  const MainPayButton({
    super.key,
    required this.total,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.fromLTRB(
        20,
        10,
        20,
        30,
      ),

      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFF5F5F5),
          ),
        ),
      ),

      child: ElevatedButton(
        onPressed: onTap,

        style: ElevatedButton.styleFrom(
          backgroundColor:
          PaymentColors.primary,

          minimumSize:
          const Size(double.infinity, 54),

          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(10),
          ),
        ),

        child: const Text(
          'PAY NOW',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

/// ================= MODAL ABA CARD =================

class ModalABACard extends StatelessWidget {
  const ModalABACard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(12),
      ),

      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,

            decoration: BoxDecoration(
              color: PaymentColors.khqrRed,
              borderRadius:
              BorderRadius.circular(8),
            ),

            child: const Center(
              child: Text(
                'KHQR',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          const Text(
            'ABA KHQR',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const Spacer(),

          const Icon(
            Icons.chevron_right,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

/// ================= MODAL PAY BUTTON =================

class ModalPayButton extends StatelessWidget {
  final VoidCallback onTap;

  const ModalPayButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,

      child: ElevatedButton(
        onPressed: onTap,

        style: ElevatedButton.styleFrom(
          backgroundColor:
          PaymentColors.darkPrimary,

          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(8),
          ),
        ),

        child: const Text(
          'PAY NOW',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

/// ================= PAYMENT ACTION TILE =================

class PaymentActionTile
    extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const PaymentActionTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}

/// ================= ABA TILE =================

class ABATile extends StatelessWidget {
  const ABATile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),

      child: Text(
        'ABA KHQR Selected',
      ),
    );
  }
}

/// ================= PAYMENT SUMMARY =================

class PaymentSummary extends StatelessWidget {
  final double subtotal;
  final double discount;
  final double total;

  const PaymentSummary({
    super.key,
    required this.subtotal,
    required this.discount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),

      child: Column(
        children: [
          _row(
            'Subtotal',
            '\$${subtotal.toStringAsFixed(2)}',
          ),

          _row(
            'Discount',
            '-\$${discount.toStringAsFixed(2)}',
          ),

          const Divider(height: 30),

          _row(
            'Total',
            '\$${total.toStringAsFixed(2)}',
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _row(
      String title,
      String value, {
        bool isBold = false,
      }) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(
        vertical: 6,
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
                  ? FontWeight.bold
                  : FontWeight.w500,
            ),
          ),

          Text(
            value,
            style: TextStyle(
              fontSize:
              isBold ? 18 : 14,
              fontWeight:
              isBold
                  ? FontWeight.bold
                  : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}