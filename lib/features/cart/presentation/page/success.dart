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
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 18,
            ),
            child: Column(
              children: [

                // Top text
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "order_successful",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Main white container
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Column(
                    children: [

                      /// Illustration Box
                      Container(
                        height: 320,
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff4D9BE6),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: Image.asset(
                          "assets/images/success.png",
                          fit: BoxFit.contain,
                        ),
                      ),

                      const SizedBox(height: 25),

                      const Text(
                        "Order successful",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 25),

                      /// Order summary card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xffD6EDF8),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [

                            _infoRow(
                              "Date",
                              "21/05/2026",
                            ),

                            const SizedBox(height: 12),

                            _infoRow(
                              "Order number",
                              "009876",
                            ),

                            const SizedBox(height: 12),

                            _infoRow(
                              "total payment",
                              "\$${totalAmount.toStringAsFixed(2)}",
                              isBold: true,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      /// Continue button
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor:
                            const Color(0xff4D9BE6),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Continues",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight:
                              FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// Back button
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.popUntil(
                              context,
                                  (route) => route.isFirst,
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Back to home",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight:
                              FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      Text(
                        "You have completed your payment.\nWe will deliver as soon as possible",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _infoRow(
      String title,
      String value, {
        bool isBold = false,
      }) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold
                ? FontWeight.bold
                : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}