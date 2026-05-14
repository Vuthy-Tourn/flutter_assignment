import 'package:flutter/material.dart';
import '../../../../core/router/app_router.dart';
import 'Vocher.dart';
import '../widgets/keyboard_widget.dart';
import '../widgets/QR_widget.dart'; // Corrected path
import 'delivery_screen.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _noteText = "";
  String _selectedDeliveryMethod = "Delivery Method";

  void _showPaymentModal(double totalAmount) {
    // Dismiss keyboard if open
    FocusScope.of(context).unfocus();

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, anim1, anim2) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  QRWidget(
                    qrData: "Your_KHQR_String_Payload",
                    merchantName: "Eternal Shine",
                    amount: totalAmount,
                  ),
                  const SizedBox(height: 24),
                  // ABA Mini Card
                  _buildModalABACard(),
                  const SizedBox(height: 16),
                  // Final Modal Button
                  _buildModalPayButton(),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("CLOSE", style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final raw = ModalRoute.of(context)?.settings.arguments;
    final items = raw != null ? List<Map<String, dynamic>>.from(raw as List) : [];

    // Logic for calculation
    double subtotal = items.fold(0, (sum, item) => sum + ((item['price'] ?? 0) * (item['qty'] ?? 1)));
    double total = subtotal - 6.20 + 1.00; // Sample calc
    const pinkColor = Color(0xFFFF2D6C);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Payment", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 120),
        child: Column(
          children: [
            // (Your existing delivery/voucher widgets here)
            _buildActionTile(Icons.local_shipping_outlined, _selectedDeliveryMethod),
            _buildPaymentSummary(subtotal, 6.20, total),
            _buildABATile(),
          ],
        ),
      ),
      bottomNavigationBar: _buildMainPayButton(pinkColor, total),
    );
  }

  // --- Main Button ---
  Widget _buildMainPayButton(Color color, double totalAmount) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      decoration: const BoxDecoration(
          color: Colors.white, border: Border(top: BorderSide(color: Color(0xFFF5F5F5)))),
      child: ElevatedButton(
        onPressed: () => _showPaymentModal(totalAmount),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size(double.infinity, 54),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Text("PAY NOW", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  // --- UI Components for the Modal ---
  Widget _buildModalABACard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: const Color(0xFFD00000), borderRadius: BorderRadius.circular(8)),
            child: const Center(child: Text("KHQR", style: TextStyle(color: Colors.white, fontSize: 8))),
          ),
          const SizedBox(width: 12),
          const Text("ABA KHQR", style: TextStyle(fontWeight: FontWeight.bold)),
          const Spacer(),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildModalPayButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8E1439), // Darker red from image
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text("PAY NOW", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  // --- Placeholders for your other existing UI ---
  Widget _buildActionTile(IconData i, String t) => ListTile(leading: Icon(i), title: Text(t));
  Widget _buildABATile() => const Padding(padding: EdgeInsets.all(20), child: Text("ABA KHQR Selected"));
  Widget _buildPaymentSummary(double s, double d, double t) => Text("Total: $t");
}