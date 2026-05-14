import 'package:flutter/material.dart';
import '../../../../core/router/app_router.dart';
import 'Vocher.dart';
import '../widgets/keyboard_widget.dart';
import '../widgets/QR_widget.dart';
import 'delivery_screen.dart';
import 'Branch_Screen.dart';
import 'up_date.dart';
import 'success.dart'; // Ensure this matches your success screen file name

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _noteText = "";
  String _selectedDeliveryMethod = "Delivery Method";
  bool _isDeliverySelected = true;
  String _selectedBranch = "Choose Branches";
  String _selectedPickUpTime = "Pick Up Time";

  // Check if ABA KHQR was selected
  bool _isKHQRSelected = false;

  final Color pinkColor = const Color(0xFFFF2D6C);
  final Color khqrRed = const Color(0xFFD50000);

  // ================= THE QR POPUP =================

  void _showQRModal(double total) {
    setState(() {
      _isKHQRSelected = true;
    });

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      barrierColor: Colors.black87,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
                child: Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: QRWidget(
                          qrData: "https://pay.khqr.com/eternal_shine_demo",
                          merchantName: "ETERNAL SHINE",
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
      transitionBuilder: (context, anim1, anim2, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
          child: child,
        );
      },
    );
  }

  // ================= CUSTOM KEYBOARD =================

  void _showCustomKeyboard() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => KeyboardWidget(
        onKeyTap: (val) => setState(() => _noteText += val),
        onDelete: () {
          if (_noteText.isNotEmpty) {
            setState(() => _noteText = _noteText.substring(0, _noteText.length - 1));
          }
        },
        onDone: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final raw = ModalRoute.of(context)?.settings.arguments;
    final items = raw != null ? List<Map<String, dynamic>>.from(raw as List) : [];

    double subtotal = items.fold(0, (sum, item) => sum + ((item['price'] ?? 0) * (item['qty'] ?? 1)));
    double discount = 6.20;
    double deliveryFee = _isDeliverySelected ? 1.0 : 0.0;
    double total = subtotal - discount + deliveryFee;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Payment", style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w700)),
      ),
      bottomNavigationBar: _buildBottomPayButton(total),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildToggle(),
            const SizedBox(height: 14),

            if (_isDeliverySelected) ...[
              _buildTile(Icons.location_on_outlined, "Address", onTap: () => Navigator.pushNamed(context, AppRouter.address)),
              _buildTile(Icons.delivery_dining_outlined, _selectedDeliveryMethod, onTap: () async {
                final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => const DeliveryScreen()));
                if (result != null && result is String) setState(() => _selectedDeliveryMethod = result);
              }),
            ] else ...[
              _buildTile(Icons.store_outlined, _selectedBranch, onTap: () {
                BranchScreen.showBranchOptions(context, (branchName) => setState(() => _selectedBranch = branchName));
              }),
              _buildTile(Icons.access_time_outlined, _selectedPickUpTime, onTap: () {
                UpDate.showPicker(context, (date, time) => setState(() => _selectedPickUpTime = "${date.day}/${date.month}/${date.year} $time"));
              }),
            ],

            _buildTile(Icons.confirmation_number_outlined, "Apply Voucher", onTap: () => Voucher.show(context)),

            const SizedBox(height: 16),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("Note", style: TextStyle(color: Colors.grey, fontSize: 12))),
            const SizedBox(height: 6),
            _buildNoteBox(),

            const SizedBox(height: 20),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("Order Summary", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
            const SizedBox(height: 10),
            ...items.map((item) => _buildItemCard(item)),

            const SizedBox(height: 20),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("PAYMENT DETAILS", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black54))
            ),
            _buildPaymentSummary(subtotal, discount, deliveryFee, total),

            _buildABAKHQRSection(total),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ================= UI BUILDERS =================

  Widget _buildABAKHQRSection(double total) {
    return GestureDetector(
      onTap: () => _showQRModal(total),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _isKHQRSelected ? pinkColor : const Color(0xFFE6E6E6), width: _isKHQRSelected ? 1.5 : 1.0),
        ),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(color: khqrRed, borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              child: const Text("KHQR", style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ABA KHQR", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  Text("Tap to show QR code", style: TextStyle(color: Colors.blueGrey, fontSize: 11)),
                ],
              ),
            ),
            const Icon(Icons.keyboard_arrow_up, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: _showCustomKeyboard,
        child: Container(
          height: 90, width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFDADADA))),
          child: Text(_noteText.isEmpty ? "Enter note" : _noteText, style: TextStyle(fontSize: 12, color: _noteText.isEmpty ? Colors.grey : Colors.black)),
        ),
      ),
    );
  }

  Widget _buildToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 38,
        decoration: BoxDecoration(color: const Color(0xFFD8D8DE), borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            _toggleItem("Delivery", _isDeliverySelected, () => setState(() => _isDeliverySelected = true)),
            _toggleItem("Pick Up", !_isDeliverySelected, () => setState(() => _isDeliverySelected = false)),
          ],
        ),
      ),
    );
  }

  Widget _toggleItem(String label, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(color: active ? pinkColor : Colors.transparent, borderRadius: BorderRadius.circular(18)),
          alignment: Alignment.center,
          child: Text(label, style: TextStyle(color: active ? Colors.white : Colors.grey, fontSize: 13, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

  Widget _buildTile(IconData icon, String title, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE6E6E6))),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500))),
            const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard(Map item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE8E8E8))),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(item['image'] ?? '', width: 60, height: 60, fit: BoxFit.cover, errorBuilder: (c, e, s) => Container(width: 60, height: 60, color: Colors.pink.shade50, child: const Icon(Icons.image, color: Colors.pink))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['name'] ?? '', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                const Text("Product description...", style: TextStyle(color: Colors.grey, fontSize: 10)),
                Text("\$${(item['price'] ?? 0).toStringAsFixed(2)}", style: TextStyle(color: pinkColor, fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
          ),
          Text("x${item['qty'] ?? 1}", style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildPaymentSummary(double sub, double disc, double fee, double total) {
    row(String t, String v, {Color? c, bool b = false}) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(t, style: TextStyle(fontSize: b ? 15 : 12, fontWeight: b ? FontWeight.w700 : FontWeight.w400)),
        Text(v, style: TextStyle(fontSize: b ? 15 : 12, fontWeight: b ? FontWeight.w700 : FontWeight.w400, color: c ?? Colors.black)),
      ]),
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          row("Sub total", "\$ ${sub.toStringAsFixed(2)}"),
          row("Discount", "-\$ ${disc.toStringAsFixed(2)}", c: Colors.pinkAccent),
          row("Birthday Discount", "-\$ 0.00", c: Colors.lightGreen),
          row("Member Discount(0.0%)", "-\$ 0.00"),
          row("Delivery Fee", "\$ ${fee.toStringAsFixed(2)}"),
          const Divider(),
          row("TOTAL", "\$ ${total.toStringAsFixed(2)}", b: true),
        ],
      ),
    );
  }

  // UPDATED NAVIGATION LOGIC HERE
  Widget _buildBottomPayButton(double total) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 25),
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: _isKHQRSelected ? () {
            // Navigate to SuccessPage when "Pay Now" is clicked
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SuccessPage(totalAmount: total),
              ),
            );
          } : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _isKHQRSelected ? pinkColor : Colors.grey.shade300,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: _isKHQRSelected ? 2 : 0,
          ),
          child: Text(
              "PAY NOW",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _isKHQRSelected ? Colors.white : Colors.grey.shade600
              )
          ),
        ),
      ),
    );
  }
}