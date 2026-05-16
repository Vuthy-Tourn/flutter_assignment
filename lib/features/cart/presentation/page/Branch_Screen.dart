import 'package:flutter/material.dart';

class BranchScreen {
  static void showBranchOptions(
      BuildContext context,
      Function(String) onSelect,
      ) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return const Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 28),
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: _BranchModal(),
        );
      },
    ).then((value) {
      if (value != null) {
        onSelect(value);
      }
    });
  }
}

// ================= POPUP UI =================

class _BranchModal extends StatefulWidget {
  const _BranchModal();

  @override
  State<_BranchModal> createState() => _BranchModalState();
}

class _BranchModalState extends State<_BranchModal> {
  final List<Map<String, String>> branches = [
    {
      "name": "ES@SMC",
      "address": "1B - 2B, 217, Steung Mean Chey 2 ,\nMean Chey , Phnom Penh"
    },
    {
      "name": "ES@PSW",
      "address": "1B - 2B, 217, Steung Mean Chey 2 ,\nMean Chey , Phnom Penh"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Branch Options",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.3,
                    color: Colors.black87,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.highlight_off,
                    color: Colors.black54,
                    size: 26,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // 🔹 Branch List Layout
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: branches.map((branch) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context, branch["name"]);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.015),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 🔹 Fixed Image Caller Setup
                        Padding(
                          padding: const EdgeInsets.only(left: 4, right: 16),
                          child: SizedBox(
                            width: 54,
                            height: 54,
                            child: Image.asset(
                              "assets/images/shopping bag.png",
                              fit: BoxFit.contain,
                              // If your asset doesn't load immediately or has an issue,
                              // this placeholder prevents your app from crashing:
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.shopping_bag, size: 44, color: Colors.blue);
                              },
                            ),
                          ),
                        ),

                        // 🔹 Branch Names & Locations Text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                branch["name"]!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.5,
                                  color: Color(0xFF5A6672),
                                  letterSpacing: -0.2,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                branch["address"]!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFFA0AEC0),
                                  height: 1.35,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}