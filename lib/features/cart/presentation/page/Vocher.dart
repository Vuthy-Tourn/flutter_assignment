import 'package:flutter/material.dart';
// Relative import to go up one level to presentation, then into widgets
import '../widgets/Voucher_wiget.dart';

class Voucher {
  static void show(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "voucher",
      // Adding a transition duration and barrier color for better UX
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, anim1, anim2) {
        return const Center(
          child: VoucherWidget(),
        );
      },
    );
  }
}