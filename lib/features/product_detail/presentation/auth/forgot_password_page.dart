import 'package:flutter/material.dart';
import 'verify_code_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  // ── COLORS ──────────────────────────────────────────────────────────────────
  static const Color pinkColor      = Color(0xFFEE82A3); // main pink
  static const Color lightPinkFill  = Color(0xFFFCEDF2); // input box background
  static const Color greyHintColor  = Color(0xFF888888); // subtitle / hint text
  static const Color backButtonBg   = Color(0xFFFFF0F5); // light pink circle behind back arrow

  // ── CONTROLLER ──────────────────────────────────────────────────────────────
  // Reads whatever the user types in the email box
  final TextEditingController _emailController = TextEditingController();

  // ── DISPOSE ─────────────────────────────────────────────────────────────────
  // Clean up the controller when this page is closed
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // ── SEND OTP LOGIC ───────────────────────────────────────────────────────────
  // Runs when the user presses "Send OTP"
  void _sendOTP() {
    bool emailIsEmpty = _emailController.text.isEmpty;

    if (!emailIsEmpty) {
      // Email was entered → go to the Verify Code page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const VerifyCodePage()),
      );
    } else {
      // Email was empty → show a small error message at the bottom
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your email address.")),
      );
    }
  }

  // ── BUILD ────────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ── APP BAR (top bar with custom back button) ───────────────────────────
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,          // no shadow under the bar
        leadingWidth: 70,      // makes space for our wider custom back button

        // The "leading" widget is what appears on the LEFT side of the AppBar
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 8.0, bottom: 8.0),

          // Container draws the pink circle background behind the arrow
          child: Container(
            decoration: const BoxDecoration(
              color: backButtonBg,       // light pink fill
              shape: BoxShape.circle,    // makes it a circle (not a square)
            ),

            // The actual back arrow button inside the circle
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: pinkColor, // pink arrow
                size: 18,
              ),
              onPressed: () => Navigator.pop(context), // go back to previous page
            ),
          ),
        ),
      ),

      // ── BODY ─────────────────────────────────────────────────────────────────
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),

        // ── COLUMN: stacks everything top to bottom ───────────────────────────
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // align children to the LEFT
          children: [

            const SizedBox(height: 40), // gap at the top

            // --- Logo ---
            Image.asset(
              'assets/images/app_logo.png',
              height: 50,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 16),

            // --- Big title ---
            const Text(
              "Forgot password",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900, // extra bold
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 12),

            // --- Subtitle instructions ---
            const Text(
              "Please enter your email to reset the password",
              style: TextStyle(color: greyHintColor, fontSize: 15),
            ),

            const SizedBox(height: 40),

            // ── EMAIL SECTION ──────────────────────────────────────────────────
            const Text(
              "Email",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),

            const SizedBox(height: 8),

            // The email input box
            TextField(
              controller: _emailController, // connects to our controller
              decoration: InputDecoration(
                hintText: "example@gmail.com",
                filled: true,
                fillColor: lightPinkFill,   // light pink background
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30), // rounded corners
                  borderSide: BorderSide.none,             // no visible border line
                ),
              ),
            ),

            const SizedBox(height: 40),

            // ── SEND OTP BUTTON ────────────────────────────────────────────────
            // SizedBox stretches the button to full screen width
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _sendOTP, // calls our function above
                style: ElevatedButton.styleFrom(
                  backgroundColor: pinkColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Send OTP",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // ── END OF COLUMN ──────────────────────────────────────────────────
          ],
        ),
      ),
    );
  }
}