import 'package:flutter/material.dart';

class KeyboardWidget extends StatefulWidget {
  final Function(String value) onKeyTap;
  final VoidCallback onDelete;
  final VoidCallback onDone;

  const KeyboardWidget({
    super.key,
    required this.onKeyTap,
    required this.onDelete,
    required this.onDone,
  });

  @override
  State<KeyboardWidget> createState() => _KeyboardWidgetState();
}

class _KeyboardWidgetState extends State<KeyboardWidget> {
  bool isUpperCase = false;

  void _toggleShift() {
    setState(() {
      isUpperCase = !isUpperCase;
    });
  }

  String _applyCase(String key) {
    return isUpperCase ? key.toUpperCase() : key;
  }

  /// Base template for every key capturing the 3D-like tactile button shadow
  Widget _baseKey({
    required Widget child,
    required VoidCallback onTap,
    required Color color,
    int flex = 10,
  }) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFF84868A),
                  offset: Offset(0, 1),
                  blurRadius: 0,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  /// Alphanumeric Character Keys
  Widget _letterKey(String letter) {
    final displayLetter = _applyCase(letter);
    return _baseKey(
      flex: 10,
      color: Colors.white,
      onTap: () => widget.onKeyTap(displayLetter),
      child: Text(
        displayLetter,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w300,
          color: Colors.black,
          letterSpacing: -0.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final row1 = "qwertyuiop".split("");
    final row2 = "asdfghjkl".split("");
    final row3 = "zxcvbnm".split("");

    // Exact slate/grey color from the image for functional keys
    const Color controlKeyBg = Color(0xFFA8B0BC);

    return Container(
      color: const Color(0xFFF2F3F5),
      width: double.infinity,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),

              /// ================= ROW 1 =================
              Row(
                children: row1.map(_letterKey).toList(),
              ),

              /// ================= ROW 2 =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: row2.map(_letterKey).toList(),
                ),
              ),

              /// ================= ROW 3 =================
              Row(
                children: [
                  // Shift Key
                  _baseKey(
                    flex: 14,
                    color: isUpperCase ? Colors.white : controlKeyBg,
                    onTap: _toggleShift,
                    child: Icon(
                      Icons.arrow_upward_outlined,
                      color: Colors.black,
                      size: 22,
                    ),
                  ),

                  ...row3.map(_letterKey),

                  // Backspace / Delete Key
                  _baseKey(
                    flex: 14,
                    color: controlKeyBg,
                    onTap: widget.onDelete,
                    child: const Icon(
                      Icons.backspace_outlined,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ],
              ),

              /// ================= ROW 4 =================
              Row(
                children: [
                  // '123' Option Switcher
                  _baseKey(
                    flex: 25,
                    color: controlKeyBg,
                    onTap: () {},
                    child: const Text(
                      "123",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  // Spacebar
                  _baseKey(
                    flex: 54,
                    color: Colors.white,
                    onTap: () => widget.onKeyTap(" "),
                    child: const Text(
                      "space",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  // Return Key
                  _baseKey(
                    flex: 25,
                    color: controlKeyBg,
                    onTap: widget.onDone,
                    child: const Text(
                      "return",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),

              /// ================= BOTTOM ROW (Emoji + Space Spacer) =================
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 10, bottom: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: Color(0xFF5A5A5A),
                      size: 30,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }
}