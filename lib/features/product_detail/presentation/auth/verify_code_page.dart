import 'package:flutter/material.dart';
// Update these paths to match your actual folder structure
import '../../../../core/theme/app_colors.dart';
import 'create_new_password_page.dart';

class VerifyCodePage extends StatefulWidget {
  const VerifyCodePage({super.key});

  @override
  State<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends State<VerifyCodePage> {
  // ── COLORS (Updated to use AppColors) ──────────────────────────────────────
  // Using the primary pink from your shared app_colors.dart
  final Color pinkColor = AppColors.primary;
  final Color backButtonBg = const Color(0xFFFFF0F5);
  final Color boxFillColor = const Color(0xFFFCEDF2);

  // ── CONTROLLER & FOCUS ───────────────────────────────────────────────────────
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final int _otpLength = 5;

  @override
  void dispose() {
    _otpController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // ── VERIFY LOGIC (Updated Flow) ─────────────────────────────────────────────
  void _verifyAndGoToCreatePassword() {
    _focusNode.unfocus();

    // NAVIGATION: Move to the Create New Password screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateNewPasswordPage()),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Code Verified Successfully!"),
        backgroundColor: Colors.green,
      ),
    );
  }

  // ── BUILD ────────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: backButtonBg,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: pinkColor, size: 18),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // Logo
              Image.asset('assets/images/app_logo.png', height: 50, fit: BoxFit.contain),
              const SizedBox(height: 16),
              const Text(
                "Verify Your Code",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
                  children: [
                    const TextSpan(text: "Please enter your code that was sent to "),
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

              // OTP INPUT AREA
              Stack(
                children: [
                  Opacity(
                    opacity: 0,
                    child: TextField(
                      controller: _otpController,
                      focusNode: _focusNode,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      maxLength: _otpLength,
                      decoration: const InputDecoration(counterText: ""),
                      onChanged: (typedValue) {
                        setState(() {});
                        if (typedValue.length == _otpLength) {
                          _verifyAndGoToCreatePassword();
                        }
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _focusNode.requestFocus(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(_otpLength, (index) {
                        String character = "";
                        if (_otpController.text.length > index) {
                          character = _otpController.text[index];
                        }
                        return _buildOTPBox(character);
                      }),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // VERIFY BUTTON
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _otpController.text.length == _otpLength
                      ? _verifyAndGoToCreatePassword
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: pinkColor,
                    disabledBackgroundColor: pinkColor.withOpacity(0.5),
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

              // RESEND ROW
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the OTP? ",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Add Resend logic here
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOTPBox(String char) {
    bool hasDigit = char.isNotEmpty;
    return Container(
      height: 60,
      width: 55,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: boxFillColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: hasDigit ? pinkColor : Colors.transparent,
          width: 2,
        ),
      ),
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