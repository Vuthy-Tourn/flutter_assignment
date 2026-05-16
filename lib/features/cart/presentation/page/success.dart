import 'package:flutter/material.dart';
import '../../../../core/router/app_router.dart'; // Ensure this path is correct

class SuccessPage extends StatelessWidget {
  final double totalAmount;

  const SuccessPage({
    super.key,
    required this.totalAmount,
  });

  /// Helper method to handle navigation back to home
  void _navigateToHome(BuildContext context) {
    // This clears the navigation stack so the user cannot "go back"
    // into the checkout/payment process.
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRouter.home, // Uses your defined route string
          (route) => false,
    );
  }

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
                // Top text (Breadcrumb style)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "ORDER SUCCESSFUL",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      letterSpacing: 1.1,
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
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
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
                          // Fallback if image is missing during development
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            Icons.check_circle_outline,
                            size: 100,
                            color: Color(0xff4D9BE6),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      const Text(
                        "Order Successful",
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
                              "Order Number",
                              "009876",
                            ),
                            const SizedBox(height: 12),
                            _infoRow(
                              "Total Payment",
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
                          onPressed: () => _navigateToHome(context),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: const Color(0xff4D9BE6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Continue",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
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
                          onPressed: () => _navigateToHome(context),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Back to Home",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      Text(
                        "You have completed your payment.\nWe will deliver as soon as possible.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                          height: 1.5,
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xff5A5A5A),
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}