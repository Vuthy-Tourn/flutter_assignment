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

  /// Toggle shift safely
  void _toggleShift() {
    setState(() {
      isUpperCase = !isUpperCase;
    });
  }

  /// Get correct letter case
  String _applyCase(String key) {
    return isUpperCase ? key.toUpperCase() : key;
  }

  /// Build normal key
  Widget _key(String k) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: GestureDetector(
          onTap: () {
            widget.onKeyTap(_applyCase(k));
          },
          child: Container(
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F3F6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _applyCase(k),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Build special key (shift/delete/etc.)
  Widget _special({
    required Widget child,
    required VoidCallback onTap,
    Color? color,
    int flex = 1,
  }) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color ?? const Color(0xFFE0E3E8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final row1 = "qwertyuiop".split("");
    final row2 = "asdfghjkl".split("");
    final row3 = "zxcvbnm".split("");

    return Container(
      color: const Color(0xFFD1D5DB),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Row 1
          Row(children: row1.map(_key).toList()),

          /// Row 2
          Row(children: row2.map(_key).toList()),

          /// Row 3 (SHIFT + letters + DELETE)
          Row(
            children: [
              _special(
                onTap: _toggleShift,
                color: isUpperCase
                    ? const Color(0xFF4A90E2) // active
                    : const Color(0xFFE0E3E8),
                child: Icon(
                  Icons.keyboard_capslock,
                  color: isUpperCase ? Colors.white : Colors.black,
                ),
              ),

              ...row3.map(_key),

              _special(
                onTap: widget.onDelete,
                child: const Icon(Icons.backspace),
              ),
            ],
          ),

          /// Bottom Row
          Row(
            children: [
              _special(
                flex: 2,
                onTap: () {},
                child: const Text("123"),
              ),
              _special(
                flex: 5,
                onTap: () => widget.onKeyTap(" "),
                color: Colors.white,
                child: const Text("space"),
              ),
              _special(
                flex: 2,
                onTap: widget.onDone,
                color: const Color(0xFF4A90E2),
                child: const Text(
                  "return",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}