import 'package:flutter/material.dart';

class DeleteSection extends StatelessWidget {
  final bool isAllSelected;
  final bool isEmpty;
  final VoidCallback onDelete;
  final ValueChanged<bool?> onSelectAll;

  const DeleteSection({
    super.key,
    required this.isAllSelected,
    required this.isEmpty,
    required this.onDelete,
    required this.onSelectAll,
  });

  static const _primaryColor = Color(0xFFFF2D6C);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTopSection(),

        // Empty State
        if (isEmpty)
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildEmptyImage(),

                        const SizedBox(height: 20),

                        const Text(
                          'No Items',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black38,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTopSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      child: Row(
        children: [
          _buildCheckbox(),

          const SizedBox(width: 4),

          const Text(
            'Select all',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black54,
            ),
          ),

          const Spacer(),

          IconButton(
            onPressed: isEmpty ? null : onDelete,
            icon: const Icon(
              Icons.delete_outline_outlined,
              size: 26,
            ),
            color: isEmpty
                ? Colors.grey.shade300
                : Colors.black45,
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox() {
    return Transform.scale(
      scale: 1.05,
      child: Checkbox(
        value: isAllSelected,
        onChanged: isEmpty ? null : onSelectAll,
        activeColor: _primaryColor,
        side: BorderSide(
          color: Colors.grey.shade300,
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Widget _buildEmptyImage() {
    return Container(
      width: 220,
      height: 220,
      alignment: Alignment.center,
      child: Image.asset(
        'assets/images/delete.png',
        fit: BoxFit.contain,

        errorBuilder: (_, error, stackTrace) {
          debugPrint('Image Error: $error');

          return const Icon(
            Icons.shopping_basket_outlined,
            size: 100,
            color: Colors.grey,
          );
        },
      ),
    );
  }
}