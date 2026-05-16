import 'package:flutter/material.dart';
import '../../../../core/router/app_router.dart';
import 'Vocher.dart';
import '../widgets/keyboard_widget.dart';
import '../widgets/QR_widget.dart';
import 'delivery_screen.dart';
import 'Branch_Screen.dart';
import 'up_date.dart';
import 'success.dart';

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

  bool _isKHQRSelected = false;

  final Color pinkColor = const Color(0xFFFF2D6C);
  final Color khqrRed = const Color(0xFFD50000);

  // ================= Logic ដើម (រក្សាទុក) =================

  void _showQRModal(double total) {
    setState(() => _isKHQRSelected = true);
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Payment",
            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      bottomNavigationBar: _buildBottomPayButton(total),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildToggle(),
            const SizedBox(height: 25),

            if (_isDeliverySelected) ...[
              _buildTile(Icons.map_outlined, "Address", onTap: () => Navigator.pushNamed(context, AppRouter.address)),
              _buildTile(Icons.local_shipping_outlined, _selectedDeliveryMethod, onTap: () async {
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

            const SizedBox(height: 25),
            _buildNoteBox(), // កែសម្រួលតាម image_856637.png

            const SizedBox(height: 25),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Text("Order Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
            const SizedBox(height: 12),
            ...items.map((item) => _buildItemCard(item)), // កែសម្រួលតាម image_856637.png

            const SizedBox(height: 25),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text("PAYMENT DETAILS", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.black87))
            ),
            _buildPaymentSummary(subtotal, discount, deliveryFee, total), // កែសម្រួលតាម image_856637.png

            _buildABAKHQRSection(total),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ================= UI BUILDERS (កែសម្រួលតាមរូបភាព) =================

  Widget _buildToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _toggleItem("Delivery", _isDeliverySelected, () => setState(() => _isDeliverySelected = true)),
          const SizedBox(width: 15),
          _toggleItem("Pick Up", !_isDeliverySelected, () => setState(() => _isDeliverySelected = false)),
        ],
      ),
    );
  }

  Widget _toggleItem(String label, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: active ? pinkColor : const Color(0xFFC4C4C4),
            borderRadius: BorderRadius.circular(25),
          ),
          alignment: Alignment.center,
          child: Text(label,
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildTile(IconData icon, String title, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 65,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(color: Color(0xFFF1F5F9), shape: BoxShape.circle),
              child: Icon(icon, size: 22, color: Colors.black87),
            ),
            const SizedBox(width: 15),
            Expanded(child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
            const Icon(Icons.chevron_right, color: Colors.grey, size: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Note", style: TextStyle(color: Color(0xFF3F51B5), fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _showCustomKeyboard,
            child: Container(
              height: 120,
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                _noteText.isEmpty ? "Enter note" : _noteText,
                style: TextStyle(fontSize: 14, color: _noteText.isEmpty ? Colors.grey.shade400 : Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(Map item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(item['image'] ?? '', width: 85, height: 85, fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(width: 85, height: 85, color: Colors.pink.shade50, child: const Icon(Icons.image, color: Colors.pink))),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['name'] ?? '', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text("Creates vivid face with gorgeous co...",
                    style: TextStyle(color: Colors.grey, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                const Text("57.00 USD", style: TextStyle(color: Colors.grey, fontSize: 10, decoration: TextDecoration.lineThrough)),
                const SizedBox(height: 5),
                Text("\$${(item['price'] ?? 0).toStringAsFixed(2).replaceAll('.00', '')}",
                    style: TextStyle(color: pinkColor, fontWeight: FontWeight.w900, fontSize: 24)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Text("x${item['qty'] ?? 1}", style: const TextStyle(fontSize: 20, color: Colors.black54)),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSummary(double sub, double disc, double fee, double total) {
    row(String t, String v, {Color? c, bool b = false}) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(t, style: TextStyle(fontSize: b ? 18 : 14, fontWeight: b ? FontWeight.w900 : FontWeight.w500)),
        Text(v, style: TextStyle(fontSize: b ? 16 : 14, fontWeight: b ? FontWeight.w900 : FontWeight.w500, color: c ?? Colors.black87)),
      ]),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        children: [
          row("Sub total", "\$ ${sub.toStringAsFixed(2)}"),
          row("Discount", "-\$ ${disc.toStringAsFixed(2)}", c: Colors.pinkAccent.shade100),
          row("Birthday Discount", "-\$ 0.00", c: Colors.lightGreen),
          row("Member Discount(0.0%)", "-\$ 0.00"),
          row("Delivery Fee", "\$ ${fee.toInt()}"),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: List.generate(40, (index) => Expanded(
                child: Container(color: index % 2 == 0 ? Colors.transparent : Colors.grey.shade200, height: 2),
              )),
            ),
          ),

          row("TOTAL", "\$ ${total.toStringAsFixed(2)}", b: true),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildABAKHQRSection(double total) {
    return GestureDetector(
      onTap: () => _showQRModal(total),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: _isKHQRSelected ? pinkColor : Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 35, height: 35,
              decoration: BoxDecoration(color: khqrRed, borderRadius: BorderRadius.circular(6)),
              alignment: Alignment.center,
              child: const Text("KHQR", style: TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ABA KHQR", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  Text("Scan to pay with any banking app", style: TextStyle(color: Colors.blueAccent, fontSize: 11)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey, size: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomPayButton(double total) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      child: SizedBox(
        height: 55,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _isKHQRSelected ? () => Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessPage(totalAmount: total))) : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _isKHQRSelected ? pinkColor : Colors.grey.shade300,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 0,
          ),
          child: const Text("PAY NOW", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ),
    );
  }
}