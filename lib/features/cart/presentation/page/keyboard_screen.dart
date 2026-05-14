import 'package:flutter/material.dart';

class ProfessionalKeyboard extends StatelessWidget {
  final Function(String) onKeyTap;
  final VoidCallback onDelete;
  final VoidCallback onDone;
  final VoidCallback? onShift;

  const ProfessionalKeyboard({
    super.key,
    required this.onKeyTap,
    required this.onDelete,
    required this.onDone,
    this.onShift,
  });

  // ================= COLORS =================
  static const Color keyboardBg = Color(0xFFD1D4D9);
  static const Color keyBg = Colors.white;
  static const Color actionKeyBg = Color(0xFFBFC3C9); // ពណ៌ប្រផេះសម្រាប់ប៊ូតុងពិសេស
  static const Color returnKeyBg = Color(0xFF4A90E2); // ពណ៌ខៀវសម្រាប់ប៊ូតុង return តាមរូប image_9e3553.png
  static const Color shadowColor = Color(0xFF888A8E);

  // ================= KEY STYLE =================
  Widget _key({
    required Widget child,
    required VoidCallback onTap,
    double? width,
    double height = 45,
    Color background = keyBg,
    bool isActionKey = false,
  }) {
    return Expanded(
      flex: width == null ? 10 : 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: shadowColor,
                  offset: Offset(0, 1),
                  blurRadius: 0,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _letterKey(String letter) {
    return _key(
      onTap: () => onKeyTap(letter),
      child: Text(
        letter,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: keyboardBg,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // === ផ្នែកខាងលើ (Top Bar/Space) ដើម្បីឱ្យដូច image_9e3553.png ===
            Container(
              height: 10, // បន្ថែម Space ផ្នែកខាងលើបន្តិច
              width: double.infinity,
              color: keyboardBg,
            ),

            // ================= ROW 1 (q-p) =================
            Row(
              children: "qwertyuiop".split("").map((e) => _letterKey(e)).toList(),
            ),

            // ================= ROW 2 (a-l) =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: "asdfghjkl".split("").map((e) => _letterKey(e)).toList(),
              ),
            ),

            // ================= ROW 3 (Shift, z-m, Delete) =================
            Row(
              children: [
                _key(
                  width: 44,
                  background: actionKeyBg,
                  onTap: onShift ?? () {},
                  child: const Icon(Icons.keyboard_capslock, size: 24),
                ),
                ...("zxcvbnm".split("").map((e) => _letterKey(e))),
                _key(
                  width: 44,
                  background: Color(0xFF2D2D2D), // ពណ៌ខ្មៅស្រដៀងក្នុងរូបភាព
                  onTap: onDelete,
                  child: const Icon(Icons.backspace, color: Colors.white, size: 18),
                ),
              ],
            ),

            // ================= ROW 4 (123, space, return) =================
            Row(
              children: [
                _key(
                  width: 85,
                  background: actionKeyBg,
                  onTap: () {},
                  child: const Text("123", style: TextStyle(fontSize: 16)),
                ),
                _key(
                  onTap: () => onKeyTap(" "),
                  child: const Text("space", style: TextStyle(fontSize: 16)),
                ),
                _key(
                  width: 85,
                  background: returnKeyBg, // ប្តូរទៅពណ៌ខៀវតាមរូប image_9e3553.png
                  onTap: onDone,
                  child: const Text(
                    "return",
                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5), // បន្ថែម Space ខាងក្រោមបន្តិច
          ],
        ),
      ),
    );
  }
}