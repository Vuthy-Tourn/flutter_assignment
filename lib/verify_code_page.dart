import 'package:flutter/material.dart';
import 'login_page.dart';

class VerifyCodePage extends StatefulWidget {
  const VerifyCodePage({super.key});

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {

  // ── COLORS ───────────────────────────────────────────────────────────────────
  final Color pinkColor     = const Color(0xFFEE82A3); // main pink
  final Color backButtonBg  = const Color(0xFFFFF0F5); // light pink circle
  final Color boxFillColor  = const Color(0xFFFCEDF2); // OTP box background

  // ── CONTROLLER & FOCUS ───────────────────────────────────────────────────────
  // _otpController: reads the digits the user types
  final TextEditingController _otpController = TextEditingController();

  // _focusNode: lets us manually open / close the keyboard
  final FocusNode _focusNode = FocusNode();

  // How many digits the OTP code should have
  final int _otpLength = 5;

  // ── DISPOSE ──────────────────────────────────────────────────────────────────
  // Always clean up controllers and focus nodes when the page closes
  @override
  void dispose() {
    _otpController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // ── VERIFY LOGIC ─────────────────────────────────────────────────────────────
  // Runs when the user finishes typing all digits OR presses "Verify"
  void _verifyAndGoToLogin() {
    // Close the keyboard first
    _focusNode.unfocus();

    // Go to Login page AND clear all previous pages from history.
    // (route) => false  means: remove every page behind us.
    // So pressing Back on Login won't return here.
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
    );

    // Show a green success message at the bottom
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Code Verified Successfully! Please Login."),
        backgroundColor: Colors.green,
      ),
    );
  }

  // ── BUILD ────────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ── APP BAR with custom pink circle back button ───────────────────────
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            // Circle background behind the arrow
            decoration: BoxDecoration(
              color: backButtonBg,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: pinkColor, size: 18),
              onPressed: () => Navigator.pop(context), // go back one page
            ),
          ),
        ),
      ),

      // ── BODY ─────────────────────────────────────────────────────────────────
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),

          // ── COLUMN: stacks everything top to bottom ───────────────────────
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 40),

              // --- Logo ---
              Image.asset('assets/images/app_logo.png', height: 50, fit: BoxFit.contain),

              const SizedBox(height: 16),

              // --- Big title ---
              const Text(
                "Verify Your Code",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              // --- Subtitle with the email shown in pink ---
              // RichText lets us style PARTS of a sentence differently
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
                  children: [
                    // Normal grey text
                    const TextSpan(text: "Please enter your code that was sent to "),
                    // Pink bold email address
                    TextSpan(
                      text: "ashwin@gmail.com",
                      style: TextStyle(
                        color: pinkColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // ── OTP INPUT AREA ────────────────────────────────────────────
              // This uses a Stack to layer two things on top of each other:
              //   Layer 1 (bottom): an invisible TextField that catches typing
              //   Layer 2 (top):    the visible pink boxes that show the digits
              Stack(
                children: [

                  // LAYER 1: Hidden TextField — the user types here,
                  // but we set opacity: 0 so they can't see it.
                  // It's still there and still receives keyboard input.
                  Opacity(
                    opacity: 0, // completely invisible
                    child: TextField(
                      controller: _otpController,
                      focusNode: _focusNode,
                      autofocus: true,                            // open keyboard automatically
                      autofillHints: const [AutofillHints.oneTimeCode],
                      keyboardType: TextInputType.number,         // number keyboard
                      maxLength: _otpLength,                      // limit to 5 digits
                      decoration: const InputDecoration(
                        counterText: "",                          // hide the "0/5" counter
                      ),
                      onChanged: (typedValue) {
                        // Redraw the pink boxes every time a digit is typed
                        setState(() {});

                        // If all 5 digits are filled → verify automatically
                        if (typedValue.length == _otpLength) {
                          _verifyAndGoToLogin();
                        }
                      },
                    ),
                  ),

                  // LAYER 2: Visible pink boxes drawn on top of the hidden TextField.
                  // Tapping anywhere here focuses the hidden TextField (opens keyboard).
                  GestureDetector(
                    onTap: () => _focusNode.requestFocus(), // open keyboard when tapped

                    // ── ROW: place 5 boxes side by side ─────────────────────
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // spread boxes evenly
                      // List.generate creates a list of 5 widgets (index 0 to 4)
                      children: List.generate(_otpLength, (index) {
                        // Get the character at this position, or "" if not typed yet
                        String character = "";
                        if (_otpController.text.length > index) {
                          character = _otpController.text[index];
                        }
                        // Build the pink box for this position
                        return _buildOTPBox(character);
                      }),
                    ),
                    // ── END OF ROW ───────────────────────────────────────────
                  ),

                ],
              ),
              // ── END OF STACK ──────────────────────────────────────────────

              const SizedBox(height: 40),

              // ── VERIFY BUTTON ─────────────────────────────────────────────
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  // Button is only active when all 5 digits are filled
                  // If not filled yet → pass null → button is greyed out
                  onPressed: _otpController.text.length == _otpLength
                      ? _verifyAndGoToLogin
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: pinkColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Verify",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ── RESEND ROW ────────────────────────────────────────────────
              // ROW: "Don't received the OTP?" and "Resend Code" sit side by side
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // Left: plain grey text
                  Text(
                    "Don't received the OTP? ",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),

                  // Right: tappable pink text
                  GestureDetector(
                    onTap: () {
                      // TODO: Add resend logic here
                    },
                    child: Text(
                      "Resend Code",
                      style: TextStyle(
                        color: pinkColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                ],
              ),
              // ── END OF ROW ────────────────────────────────────────────────

            ],
          ),
          // ── END OF COLUMN ──────────────────────────────────────────────────
        ),
      ),
    );
  }

  // ── HELPER: builds ONE pink OTP box ──────────────────────────────────────────
  // char = the digit to show, or "" if the user hasn't typed here yet
  Widget _buildOTPBox(String char) {
    bool hasDigit = char.isNotEmpty; // true if this box has a number in it

    return Container(
      height: 60,
      width: 55,
      alignment: Alignment.center, // center the digit inside the box

      decoration: BoxDecoration(
        color: boxFillColor,                          // light pink background
        borderRadius: BorderRadius.circular(15),      // rounded corners

        // Show a pink border if this box has a digit, otherwise no border
        border: Border.all(
          color: hasDigit ? pinkColor : Colors.transparent,
          width: 2,
        ),
      ),

      // Show the digit if typed, otherwise show a "-" placeholder
      child: Text(
        char.isEmpty ? "-" : char,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}