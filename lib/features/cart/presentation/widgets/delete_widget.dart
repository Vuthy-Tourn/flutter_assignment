import 'package:flutter/material.dart';

class DeletePaymentBar extends StatelessWidget {
  final bool hasItems;
  final int count;
  final double total;
  final VoidCallback onCheckout;

  const DeletePaymentBar({
    super.key,
    required this.hasItems,
    required this.count,
    required this.total,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: hasItems ? onCheckout : null,
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: hasItems ? Colors.pink : Colors.grey[300],
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Place order ($count)",
                  style: TextStyle(
                    color: hasItems ? Colors.white : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text("Sub total",
                  style: TextStyle(color: Colors.grey)),
              Text(
                "\$${total.toStringAsFixed(2)}",
                style: TextStyle(
                  color: hasItems ? Colors.pink : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}