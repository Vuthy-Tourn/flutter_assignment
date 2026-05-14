import 'package:flutter/material.dart';

class DeleteSection extends StatelessWidget {
  final bool isAllSelected;
  final VoidCallback onDelete;
  final Function(bool?) onSelectAll;
  final bool isEmpty;

  const DeleteSection({
    super.key,
    required this.isAllSelected,
    required this.onDelete,
    required this.onSelectAll,
    required this.isEmpty,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// 🔘 SELECT ALL + DELETE
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              Checkbox(
                value: isAllSelected,
                onChanged: isEmpty ? null : onSelectAll,
              ),
              const Text("Select all"),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                color: isEmpty ? Colors.grey[400] : Colors.black,
                onPressed: isEmpty ? null : onDelete,
              ),
            ],
          ),
        ),


        if (isEmpty)
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/empty_cart.png',
                    width: 120,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "No Items",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}