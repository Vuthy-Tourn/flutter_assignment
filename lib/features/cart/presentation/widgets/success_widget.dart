import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  final double totalAmount;

  const SuccessPage({
    super.key,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("order_successful", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ),
              const SizedBox(height: 20),

              // Illustration Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF4290D1), width: 1.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.network(
                  'https://cdni.iconscout.com/illustration/premium/thumb/order-confirmation-illustration-4541940.png',
                  height: 220,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.check_circle, size: 80, color: Colors.green),
                ),
              ),
              const SizedBox(height: 15),

              const Text("Order successful", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              // Summary Card (Matches Image Layout)
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFD1E9F6), // Light blue background
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    _infoRow("Date", "21/05/2026"),
                    const SizedBox(height: 10),
                    _infoRow("Order number", "009876"),
                    const SizedBox(height: 10),
                    _infoRow("total payment", "\$${totalAmount.toStringAsFixed(2)}", isBold: true),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // "Continues" Button
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4290D1),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Continues", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),

              // "Back to home" Button
              OutlinedButton(
                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Back to home", style: TextStyle(color: Colors.black, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF5D7B93), fontSize: 13)),
        Text(value, style: TextStyle(
          fontSize: 13,
          fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          color: Colors.black,
        )),
      ],
    );
  }
}