import 'package:flutter/material.dart';
import '../widgets/Branch_widget.dart';

class BranchScreen {
  static void showBranchOptions(
      BuildContext context,
      Function(String) onSelect,
      ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return const _BranchModal();
      },
    ).then((value) {
      if (value != null) {
        onSelect(value);
      }
    });
  }
}

// ================= MODAL UI =================

class _BranchModal extends StatefulWidget {
  const _BranchModal();

  @override
  State<_BranchModal> createState() => _BranchModalState();
}

class _BranchModalState extends State<_BranchModal> {
  String selectedBranch = "";

  final List<Map<String, String>> branches = [
    {
      "name": "ES@SMC",
      "address":
      "1B - 2B, 217, Steung Mean Chey 2, Mean Chey, Phnom Penh"
    },
    {
      "name": "ES@PSW",
      "address":
      "1B - 2B, 217, Steung Mean Chey 2, Mean Chey, Phnom Penh"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        children: [
          // 🔹 Drag Indicator
          const SizedBox(height: 10),
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          // 🔹 Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Choose Branch",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.grey),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // 🔹 Branch List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: branches.length,
              itemBuilder: (context, index) {
                final branch = branches[index];
                final isSelected = selectedBranch == branch["name"];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedBranch = branch["name"]!;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFFFF0F5)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFFFF2D6C)
                            : Colors.grey.shade300,
                        width: 1.5,
                      ),
                      boxShadow: [
                        if (!isSelected)
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // 🔹 Icon
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFFF2D6C)
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.store,
                            color: isSelected
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),

                        const SizedBox(width: 15),

                        // 🔹 Text
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                branch["name"]!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                branch["address"]!,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // 🔹 Selected Icon
                        if (isSelected)
                          const Icon(Icons.check_circle,
                              color: Color(0xFFFF2D6C)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // 🔹 Confirm Button
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: selectedBranch.isEmpty
                    ? null
                    : () => Navigator.pop(context, selectedBranch),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF2D6C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "CONFIRM",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}