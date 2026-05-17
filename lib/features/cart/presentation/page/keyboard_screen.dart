import 'package:flutter/material.dart';

class ProfessionalKeyboard extends StatelessWidget {
  final ValueChanged<String> onKeyTap;
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

  /// ================= CONSTANTS =================

  static const Color keyboardBg = Color(0xFFD1D4D9);
  static const Color keyBg = Colors.white;
  static const Color actionKeyBg = Color(0xFFBFC3C9);
  static const Color returnKeyBg = Color(0xFF4A90E2);
  static const Color deleteKeyBg = Color(0xFF2D2D2D);
  static const Color shadowColor = Color(0xFF888A8E);

  static const List<String> row1 = [
    'q',
    'w',
    'e',
    'r',
    't',
    'y',
    'u',
    'i',
    'o',
    'p',
  ];

  static const List<String> row2 = [
    'a',
    's',
    'd',
    'f',
    'g',
    'h',
    'j',
    'k',
    'l',
  ];

  static const List<String> row3 = [
    'z',
    'x',
    'c',
    'v',
    'b',
    'n',
    'm',
  ];

  /// ================= UI =================

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
            const SizedBox(height: 10),

            /// ================= ROW 1 =================
            _buildLetterRow(row1),

            /// ================= ROW 2 =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: _buildLetterRow(row2),
            ),

            /// ================= ROW 3 =================
            Row(
              children: [
                KeyboardKey(
                  width: 44,
                  background: actionKeyBg,
                  onTap: onShift ?? () {},
                  child: const Icon(
                    Icons.keyboard_capslock,
                    size: 24,
                  ),
                ),

                ...row3.map(_buildLetterKey),

                KeyboardKey(
                  width: 44,
                  background: deleteKeyBg,
                  onTap: onDelete,
                  child: const Icon(
                    Icons.backspace,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ],
            ),

            /// ================= ROW 4 =================
            Row(
              children: [
                KeyboardKey(
                  width: 85,
                  background: actionKeyBg,
                  onTap: () {},
                  child: const Text(
                    '123',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                KeyboardKey(
                  onTap: () => onKeyTap(' '),
                  child: const Text(
                    'space',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                KeyboardKey(
                  width: 85,
                  background: returnKeyBg,
                  onTap: onDone,
                  child: const Text(
                    'return',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  /// ================= HELPERS =================

  Widget _buildLetterRow(List<String> letters) {
    return Row(
      children: letters.map(_buildLetterKey).toList(),
    );
  }

  Widget _buildLetterKey(String letter) {
    return KeyboardKey(
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
}

/// ================= KEY WIDGET =================

class KeyboardKey extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final double? width;
  final double height;
  final Color background;

  const KeyboardKey({
    super.key,
    required this.child,
    required this.onTap,
    this.width,
    this.height = 45,
    this.background = ProfessionalKeyboard.keyBg,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: width == null ? 10 : 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 3,
          vertical: 5,
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: width,
            height: height,
            alignment: Alignment.center,

            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: ProfessionalKeyboard.shadowColor,
                  offset: Offset(0, 1),
                  blurRadius: 0,
                ),
              ],
            ),

            child: child,
          ),
        ),
      ),
    );
  }
}