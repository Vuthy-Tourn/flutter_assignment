import 'package:flutter/material.dart';
import '../widgets/pickup_widget.dart';

class PickupScreen extends StatefulWidget {
  const PickupScreen({super.key});

  @override
  State<PickupScreen> createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  // Logic: true shows Delivery UI, false shows Pick Up UI
  bool isDelivery = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Payment",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, color: Colors.grey[200]),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- SWITCHER SECTION ---
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isDelivery = true),
                        child: ToggleButton(title: "Delivery", isActive: isDelivery),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => isDelivery = false),
                        child: ToggleButton(title: "Pick Up", isActive: !isDelivery),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- DYNAMIC CONTENT BASED ON SELECTION ---
            if (isDelivery) ...[
              const OptionTile(icon: Icons.map_outlined, title: "Address"),
              const OptionTile(icon: Icons.local_shipping_outlined, title: "Standard Delivery"),
            ] else ...[
              const OptionTile(icon: Icons.store_outlined, title: "Choose Branches"),
              const OptionTile(icon: Icons.access_time, title: "Pick Up Time"),
            ],

            // Common Widgets
            const OptionTile(icon: Icons.confirmation_number_outlined, title: "Apply Voucher"),
            const NoteInputSection(),
            const OrderSummarySection(),
            const PaymentDetailsSection(),
          ],
        ),
      ),
      bottomNavigationBar: const PayNowBottomBar(),
    );
  }
}