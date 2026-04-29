import 'package:flutter/material.dart';
import 'package:flutter_product_detail_app/features/product_detail/presentation/auth/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // ── COLORS ─────────────────────────────────────────────────────────────────
  static const Color pinkColor = Color(0xFFEE82A3);
  static const Color lightPinkFill = Color(0xFFFCEDF2);
  static const Color darkLabelColor = Color(0xFF333333);
  static const Color greyHintColor = Color(0xFF888888);
  static const Color backButtonBg = Color(0xFFFFF0F5);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _goToLoginPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _handleSignUp() {
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;
    if (password.isNotEmpty && password == confirmPassword) {
      _goToLoginPage();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match!"), backgroundColor: Colors.red),
      );
    }
  }

  Widget _socialButton(String iconPath) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade200),
        color: Colors.white,
      ),
      child: Image.asset(
        iconPath,
        height: 24,
        width: 24,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.help_outline, size: 24, color: Colors.grey),
      ),
    );
  }

  Widget _buildLabel(String labelText) {
    return Text(
      labelText,
      style: const TextStyle(color: darkLabelColor, fontWeight: FontWeight.bold, fontSize: 15),
    );
  }

  InputDecoration _buildInputDecoration({required String hintText, required IconData icon, bool isPassword = false, bool obscureText = false, VoidCallback? onToggle}) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(icon, color: Colors.grey, size: 22),
      filled: true,
      fillColor: lightPinkFill,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
      suffixIcon: isPassword ? IconButton(icon: Icon(obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey), onPressed: onToggle) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: backButtonBg,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: pinkColor, size: 18),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      // LayoutBuilder helps calculate available screen height
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ConstrainedBox(
              // Ensures the column is at least as tall as the screen
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: AutofillGroup(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Image.asset('assets/images/app_logo.png', height: 40, fit: BoxFit.contain),
                      const SizedBox(height: 20),
                      const Text(
                        "Sign up to your\nAccount",
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black, height: 1.1),
                      ),
                      const SizedBox(height: 8),
                      const Text("Create your account to get started", style: TextStyle(color: greyHintColor, fontSize: 14)),

                      const SizedBox(height: 16),
                      _buildLabel("Email"),
                      const SizedBox(height: 8),
                      TextField(controller: _emailController, decoration: _buildInputDecoration(hintText: "example@gmail.com", icon: Icons.email_outlined)),

                      const SizedBox(height: 16),
                      _buildLabel("Password"),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: _buildInputDecoration(
                            hintText: "Enter your password",
                            icon: Icons.lock_outline,
                            isPassword: true,
                            obscureText: _obscurePassword,
                            onToggle: () => setState(() => _obscurePassword = !_obscurePassword)
                        ),
                      ),

                      const SizedBox(height: 16),
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
                            onToggle: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword)
                        ),
                      ),

                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _handleSignUp,
                          style: ElevatedButton.styleFrom(backgroundColor: pinkColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), elevation: 0),
                          child: const Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ),

                      // Spacer pushes the social section to the bottom if there is room
                      const Spacer(),

                      const SizedBox(height: 35),
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                          const Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text("Or login with", style: TextStyle(color: greyHintColor, fontSize: 14))),
                          Expanded(child: Divider(color: Colors.grey.shade300)),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _socialButton('assets/images/google_icon.png'),
                          const SizedBox(width: 20),
                          _socialButton('assets/images/facebook_icon.png'),
                          const SizedBox(width: 20),
                          _socialButton('assets/images/apple_icon.png'),
                        ],
                      ),
                      const SizedBox(height: 35),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? ", style: TextStyle(color: greyHintColor)),
                          GestureDetector(
                            onTap: _goToLoginPage,
                            child: const Text("Log In", style: TextStyle(color: pinkColor, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 90),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}