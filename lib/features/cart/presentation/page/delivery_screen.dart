import 'package:flutter/material.dart';

import '../widgets/delivery_widget.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

/// ================= MODEL =================

class DeliveryMethod {
  final String title;
  final String duration;
  final String price;
  final IconData icon;

  const DeliveryMethod({
    required this.title,
    required this.duration,
    required this.price,
    required this.icon,
  });
}

/// ================= SCREEN =================

class _DeliveryScreenState extends State<DeliveryScreen> {
  String selectedMethod = 'Standard Delivery';

  final List<DeliveryMethod> methods = const [
    DeliveryMethod(
      title: 'Standard Delivery',
      duration: '3-5 business days',
      price: '\$1.00',
      icon: Icons.local_shipping_outlined,
    ),

    DeliveryMethod(
      title: 'Express Delivery',
      duration: '1-2 business days',
      price: '\$5.00',
      icon: Icons.speed,
    ),

    DeliveryMethod(
      title: 'Instant Delivery',
      duration: 'Same day delivery',
      price: '\$10.00',
      icon: Icons.bolt,
    ),
  ];

  /// ================= LOGIC =================

  void _selectMethod(String method) {
    setState(() {
      selectedMethod = method;
    });
  }

  void _confirmSelection() {
    Navigator.pop(context, selectedMethod);
  }

  /// ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: _buildAppBar(),

      body: Column(
        children: [
          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFF5F5F5),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              itemCount: methods.length,
              itemBuilder: (_, index) {
                final method = methods[index];

                return DeliveryWidget(
                  title: method.title,
                  duration: method.duration,
                  price: method.price,
                  icon: method.icon,

                  isSelected:
                  selectedMethod == method.title,

                  onTap: () =>
                      _selectMethod(method.title),
                );
              },
            ),
          ),

          ConfirmButton(
            onTap: _confirmSelection,
          ),
        ],
      ),
    );
  }

  /// ================= APP BAR =================

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,

      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          size: 20,
          color: Colors.grey,
        ),
        onPressed: () => Navigator.pop(context),
      ),

      title: const Text(
        'Delivery Method',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

/// ================= CONFIRM BUTTON =================

class ConfirmButton extends StatelessWidget {
  final VoidCallback onTap;

  const ConfirmButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        10,
        20,
        40,
      ),
      child: ElevatedButton(
        onPressed: onTap,

        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF2D6C),
          minimumSize: const Size(
            double.infinity,
            54,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        child: const Text(
          'CONFIRM METHOD',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}