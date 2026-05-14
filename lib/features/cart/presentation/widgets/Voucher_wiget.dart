import 'package:flutter/material.dart';

class VoucherWidget extends StatelessWidget {
  const VoucherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Material ancestor is required for TextFields to render correctly
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Apply Voucher",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.black),
                )
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Enter voucher code",
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Icon(Icons.local_offer, size: 60, color: Colors.grey),
            const SizedBox(height: 10),
            const Text(
              "No Voucher Available",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}