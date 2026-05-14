import 'package:flutter/material.dart';
import '../widgets/delivery_widget.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  // Track which method is selected
  String selectedMethod = "Standard Delivery";

  final List<Map<String, dynamic>> methods = [
    {
      "title": "Standard Delivery",
      "duration": "3-5 business days",
      "price": "\$1.00",
      "icon": Icons.local_shipping_outlined,
    },
    {
      "title": "Express Delivery",
      "duration": "1-2 business days",
      "price": "\$5.00",
      "icon": Icons.speed,
    },
    {
      "title": "Instant Delivery",
      "duration": "Same day delivery",
      "price": "\$10.00",
      "icon": Icons.bolt,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.grey),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Delivery Method",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Divider(height: 1, thickness: 1, color: Color(0xFFF5F5F5)),
          const SizedBox(height: 20),

          // Generate the list of delivery options
          Expanded(
            child: ListView.builder(
              itemCount: methods.length,
              itemBuilder: (context, index) {
                final method = methods[index];
                return DeliveryWidget(
                  title: method['title'],
                  duration: method['duration'],
                  price: method['price'],
                  icon: method['icon'],
                  isSelected: selectedMethod == method['title'],
                  onTap: () {
                    setState(() {
                      selectedMethod = method['title'];
                    });
                  },
                );
              },
            ),
          ),

          // Bottom Selection Button
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
            child: ElevatedButton(
              onPressed: () {
                // Return the selected method to the Payment Page
                Navigator.pop(context, selectedMethod);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF2D6C),
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                "CONFIRM METHOD",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}