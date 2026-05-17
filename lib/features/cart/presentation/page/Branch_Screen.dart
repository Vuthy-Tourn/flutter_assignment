import 'package:flutter/material.dart';

class BranchScreen {
  static Future<void> showBranchOptions(
      BuildContext context,
      ValueChanged<String> onSelect,
      ) async {
    final result = await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (_) => const Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: EdgeInsets.symmetric(horizontal: 28),
        child: BranchModal(),
      ),
    );

    if (result != null) {
      onSelect(result);
    }
  }
}

/// ================= MODEL =================

class BranchModel {
  final String name;
  final String address;

  const BranchModel({
    required this.name,
    required this.address,
  });
}

/// ================= CONSTANTS =================

class BranchStyles {
  static const primaryBorder = Color(0xFFE2E8F0);
  static const titleColor = Color(0xFF5A6672);
  static const subtitleColor = Color(0xFFA0AEC0);
}

/// ================= MODAL =================

class BranchModal extends StatelessWidget {
  const BranchModal({super.key});

  static const List<BranchModel> branches = [
    BranchModel(
      name: 'ES@SMC',
      address:
      '1B - 2B, 217, Steung Mean Chey 2,\nMean Chey, Phnom Penh',
    ),
    BranchModel(
      name: 'ES@PSW',
      address:
      '1B - 2B, 217, Steung Mean Chey 2,\nMean Chey, Phnom Penh',
    ),
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
        children: [
          const _ModalHeader(),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: branches
                  .map(
                    (branch) => BranchCard(branch: branch),
              )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= HEADER =================

class _ModalHeader extends StatelessWidget {
  const _ModalHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Branch Options',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.3,
              color: Colors.black87,
            ),
          ),

          InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(20),
            child: const Icon(
              Icons.highlight_off,
              size: 26,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= BRANCH CARD =================

class BranchCard extends StatelessWidget {
  final BranchModel branch;

  const BranchCard({
    super.key,
    required this.branch,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => Navigator.pop(context, branch.name),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: BranchStyles.primaryBorder,
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
          children: [
            const _BranchImage(),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    branch.name,
                    style: const TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w700,
                      color: BranchStyles.titleColor,
                      letterSpacing: -0.2,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    branch.address,
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.35,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.1,
                      color: BranchStyles.subtitleColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= IMAGE =================

class _BranchImage extends StatelessWidget {
  const _BranchImage();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 54,
      height: 54,
      child: Image.asset(
        'assets/images/shopping bag.png',
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) {
          return const Icon(
            Icons.shopping_bag,
            size: 44,
            color: Colors.blue,
          );
        },
      ),
    );
  }
}