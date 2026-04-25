import 'package:flutter/material.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  // ── COLORS ─────────────────────────────────────────────────────────────────
  static const Color pinkColor      = Color(0xFFEE82A3); // main pink
  static const Color lightPinkFill  = Color(0xFFFCEDF2); // input box background
  static const Color darkLabelColor = Color(0xFF333333); // label text color
  static const Color greyHintColor  = Color(0xFF888888); // hint / subtitle color
  static const Color backButtonBg   = Color(0xFFFFF0F5); // ← Bug 1 fix: was missing

  // ── CONTROLLERS ────────────────────────────────────────────────────────────
  final TextEditingController _emailController           = TextEditingController();
  final TextEditingController _passwordController        = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // ── STATE VARIABLES ────────────────────────────────────────────────────────
  bool _obscurePassword        = true;
  bool _obscureConfirmPassword = true;

  // ── DISPOSE ────────────────────────────────────────────────────────────────
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // ── NAVIGATION ─────────────────────────────────────────────────────────────
  void _goToLoginPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  // ── SIGN UP BUTTON LOGIC ───────────────────────────────────────────────────
  void _handleSignUp() {
    final String password        = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    bool passwordsMatch = password.isNotEmpty && password == confirmPassword;

    if (passwordsMatch) {
      _goToLoginPage();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match or are empty!"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ── BUILD ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ── APP BAR ────────────────────────────────────────────────────────────
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 8.0, bottom: 8.0),
          child: Container(
            decoration: const BoxDecoration(
              color: backButtonBg,    // now works because we defined it above
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: pinkColor, size: 18),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),

      // ── BODY ─────────────────────────────────────────────────────────────
      // ← Bug 2 fix: body: and SingleChildScrollView were missing
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: AutofillGroup(

          // ── COLUMN: stack everything top to bottom ────────────────────────
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 40),

              // --- Logo ---
              Image.asset('assets/images/app_logo.png', height: 50, fit: BoxFit.contain),

              const SizedBox(height: 16),

              // --- Big title ---
              const Text(
                "Sign up to your\nAccount",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.1,
                ),
              ),

              const SizedBox(height: 10),

              // --- Subtitle ---
              const Text(
                "Create your account to get started",
                style: TextStyle(color: greyHintColor, fontSize: 15),
              ),

              const SizedBox(height: 35),

              // ── EMAIL SECTION ─────────────────────────────────────────────
              _buildLabel("Email"),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                autofillHints: const [AutofillHints.email],
                keyboardType: TextInputType.emailAddress,
                decoration: _buildInputDecoration(
                  hintText: "example@gmail.com",
                  icon: Icons.email_outlined,
                ),
              ),

              const SizedBox(height: 20),

              // ── PASSWORD SECTION ──────────────────────────────────────────
              _buildLabel("Password"),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                autofillHints: const [AutofillHints.newPassword],
                decoration: _buildInputDecoration(
                  hintText: "Enter your password",
                  icon: Icons.lock_outline,
                  isPassword: true,
                  obscureText: _obscurePassword,
                  onToggle: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),

              const SizedBox(height: 20),

              // ── CONFIRM PASSWORD SECTION ──────────────────────────────────
              _buildLabel("Confirm Password"),
              const SizedBox(height: 8),
              TextField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: _buildInputDecoration(
                  hintText: "Repeat your password",
                  icon: Icons.lock_reset_outlined,
                  isPassword: true,
                  obscureText: _obscureConfirmPassword,
                  onToggle: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                ),
              ),

              const SizedBox(height: 30),

              // ── SIGN UP BUTTON ────────────────────────────────────────────
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _handleSignUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: pinkColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ── ALREADY HAVE AN ACCOUNT ROW ───────────────────────────────
              // ROW: two texts placed side by side
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? ", style: TextStyle(color: greyHintColor)),
                  GestureDetector(
                    onTap: _goToLoginPage,
                    child: const Text(
                      "Log In",
                      style: TextStyle(color: pinkColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              // ── END OF ROW ─────────────────────────────────────────────────

              const SizedBox(height: 20),

            ],
          ),
          // ── END OF COLUMN ──────────────────────────────────────────────────
        ),
      ),
    );
  }

  // ── HELPER: label above each text field ────────────────────────────────────
  Widget _buildLabel(String labelText) {
    return Text(
      labelText,
      style: const TextStyle(color: darkLabelColor, fontWeight: FontWeight.bold, fontSize: 15),
    );
  }

  // ── HELPER: pink rounded decoration for each TextField ─────────────────────
  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggle,
  }) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(icon, color: Colors.grey, size: 22),
      filled: true,
      fillColor: lightPinkFill,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      suffixIcon: isPassword
          ? IconButton(
        icon: Icon(
          obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: Colors.grey,
        ),
        onPressed: onToggle,
      )
          : null,
    );
  }
}