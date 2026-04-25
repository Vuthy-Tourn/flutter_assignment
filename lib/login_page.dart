import 'package:flutter/material.dart';
import 'sign_up_page.dart';
import 'forgot_password_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // These variables track the page's "state" (things that can change)
  bool _isLoading = false;        // true = show spinning circle, false = show button
  bool _obscurePassword = true;   // true = hide password, false = show password

  // Controllers let us read what the user typed inside a TextField
  final TextEditingController _emailController =
  TextEditingController(text: "ashwin@gmail.com");
  final TextEditingController _passwordController =
  TextEditingController(text: "12345678");

  // This function runs when the user presses "Log In"
  void _handleLogin() async {
    // Show the loading spinner
    setState(() => _isLoading = true);

    // Wait 2 seconds (pretending to contact a server)
    await Future.delayed(const Duration(seconds: 2));

    // After waiting, go to the Home page
    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  // Always clean up controllers when the page is closed
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define our colors here so we can reuse them easily
    const Color pinkColor = Color(0xFFEE82A3);       // the main pink color
    const Color lightPinkFill = Color(0xFFFCEDF2);   // light pink background for text fields

    return Scaffold(
      backgroundColor: Colors.white,

      // SafeArea keeps content away from the camera notch / status bar
      body: SafeArea(
        // SingleChildScrollView lets the page scroll if the keyboard pops up
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),

          // AutofillGroup helps the phone suggest saved emails/passwords
          child: AutofillGroup(

            // ─── COLUMN: stacks everything top to bottom ───────────────────
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // align children to the LEFT
              children: [

                // --- Space at the top ---
                const SizedBox(height: 40),

                // --- App logo image ---
                Image.asset(
                  'assets/images/app_logo.png',
                  height: 50,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 40), // gap between logo and title

                // --- Big title text ---
                const Text(
                  "Sign in to your\nAccount",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    height: 1.2, // line spacing
                  ),
                ),

                const SizedBox(height: 10),

                // --- Smaller subtitle text ---
                Text(
                  "Enter your email and password to log in",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                ),

                const SizedBox(height: 40),

                // ── EMAIL SECTION ──────────────────────────────────────────
                const Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                const SizedBox(height: 8),

                // The actual email input box
                TextField(
                  controller: _emailController,         // connects to our controller above
                  keyboardType: TextInputType.emailAddress, // shows email keyboard
                  decoration: InputDecoration(
                    hintText: "example@gmail.com",
                    filled: true,
                    fillColor: lightPinkFill,            // light pink background
                    prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30), // rounded corners
                      borderSide: BorderSide.none,             // no visible border line
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ── PASSWORD SECTION ───────────────────────────────────────
                const Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                const SizedBox(height: 8),

                // The actual password input box
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword, // hides/shows the password text
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    filled: true,
                    fillColor: lightPinkFill,
                    prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),

                    // Eye icon button on the RIGHT side of the password field
                    suffixIcon: IconButton(
                      // Show a different eye icon depending on if password is hidden or not
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined  // eye with slash = hidden
                            : Icons.visibility_outlined,     // open eye = visible
                      ),
                      // Toggle hide/show when the user taps the eye
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                // ── FORGOT PASSWORD (pushed to the right) ─────────────────
                // Align moves its child to a specific spot (here: right side)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: pinkColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ── LOG IN BUTTON ──────────────────────────────────────────
                // SizedBox forces the button to be full width
                SizedBox(
                  width: double.infinity, // stretch to full screen width
                  height: 56,
                  child: ElevatedButton(
                    // If loading, disable the button (pass null); otherwise run _handleLogin
                    onPressed: _isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: pinkColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),

                    // Show a spinner while loading, otherwise show "Log In" text
                    child: _isLoading
                        ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : const Text(
                      "Log In",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // ── SIGN UP ROW ────────────────────────────────────────────
                // ROW: places widgets side by side (left to right)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // center everything horizontally
                  children: [

                    // Left part: plain grey text
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
                    ),

                    // Right part: tappable pink "Sign Up" text
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: pinkColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),

                  ],
                ),
                // ── END OF SIGN UP ROW ─────────────────────────────────────

              ],
            ),
            // ── END OF COLUMN ───────────────────────────────────────────────
          ),
        ),
      ),
    );
  }
}