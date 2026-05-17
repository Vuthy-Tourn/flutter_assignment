import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[300], // Background to easily see the white dialog card
        body: const Center(
          child: VoucherWidget(),
        ),
      ),
    );
  }
}

class VoucherWidget extends StatelessWidget {
  const VoucherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Material ancestor is required for TextFields to render correctly
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Row: Title and Close button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Apply Voucher",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    letterSpacing: -0.2,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black87, width: 1.5),
                    ),
                    child: const Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.black87
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),

            // Voucher Code Input Field
            TextField(
              style: const TextStyle(color: Colors.black, fontSize: 16),
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                hintText: "Voucher Code",
                hintStyle: TextStyle(
                    color: Colors.grey.shade300,
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade600, width: 1.2),
                ),
              ),
            ),
            const SizedBox(height: 50),

            // Recreated Pastel Voucher Graphic Illustration
            _buildVoucherIllustration(),

            const SizedBox(height: 16),

            // "No Voucher" text notice
            Text(
              "No Voucher",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Beautifully constructs the custom gift box graphic using pure Flutter widgets
  Widget _buildVoucherIllustration() {
    return SizedBox(
      width: 140,
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Sparkle Spark 1 (Left Cyan Star)
          Positioned(
            left: 15,
            top: 60,
            child: Icon(Icons.star, size: 10, color: Colors.cyan.shade100),
          ),
          // Sparkle Spark 2 (Right Purple Star)
          Positioned(
            right: 15,
            bottom: 40,
            child: Icon(Icons.star, size: 10, color: Colors.purple.shade100),
          ),
          // Green Lightning/Zap Spark (Top Right)
          Positioned(
            right: 15,
            top: 50,
            child: Transform.rotate(
              angle: 0.1,
              child: Icon(Icons.flash_on, size: 18, color: Colors.teal.shade100),
            ),
          ),
          // Main Purple Gift Box Base Container
          Positioned(
            bottom: 25,
            child: Transform.rotate(
              angle: -0.1,
              child: Container(
                width: 70,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFB4B3E4), // Accurate pastel purple
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
          // Yellow Percentage Coupon sliding out of the box
          Positioned(
            top: 38,
            right: 36,
            child: Transform.rotate(
              angle: 0.3,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1C5), // Pastel yellow coupon skin
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                    Icons.percent_rounded,
                    size: 26,
                    color: Color(0xFFFFD466) // Slightly darker yellow for % icon
                ),
              ),
            ),
          ),
          // Light Pink Ribbon Bow (Top cap of the box)
          Positioned(
            top: 32,
            left: 32,
            child: Transform.rotate(
              angle: -0.2,
              child: Image.network(
                'https://cdn-icons-png.flaticon.com/512/2267/2267911.png',
                width: 55,
                height: 55,
                color: const Color(0xFFF9D2E4), // Pastel pink overlay
                errorBuilder: (context, error, stackTrace) {
                  // Fallback icon widget if network is unavailable
                  return Icon(Icons.featured_play_list_rounded, size: 45, color: Colors.pink.shade100);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}