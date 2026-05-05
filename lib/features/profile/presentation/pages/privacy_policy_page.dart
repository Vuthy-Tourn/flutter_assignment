import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFCFD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFCFD),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Color(0xFFFF79A2),
            size: 28,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2B2B2B),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),

            // Logo
            Center(
              child: Column(
                children: [
                  Text(
                    'Eternal',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFFF79A2),
                      height: 1.1,
                    ),
                  ),
                  Text(
                    'Shine',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFFF79A2),
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            ..._sections.map(
              (s) => _PolicySection(title: s['title']!, body: s['body']!),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  static const List<Map<String, String>> _sections = [
    {
      'title': '1. Introduction',
      'body':
          'Your privacy is important to us, and we are committed to protecting your personal information. This Privacy Policy outlines how we collect, use, and share your information when you use our App.',
    },
    {
      'title': '2. Information We Collect',
      'body':
          'When you use our App, we may collect personal information such as your name, email address, shipping address, and phone number. You may also choose to provide your date of birth on a voluntary basis to access specialized membership features.',
    },
    {
      'title': '3. Purpose of Data Collection',
      'body':
          'We collect your information for the following purposes:\n• Order Fulfillment: Processing orders and facilitating transactions.\n• User Identification: Personalizing your shopping experience and providing customer support.\n• Communications: Sending promotional emails, updates, and improving app performance.',
    },
    {
      'title': '4. Sharing Your Information',
      'body':
          'To achieve these purposes, we may share your information with third parties. This includes payment processors who handle transactions, shipping companies that fulfill orders, and analytics providers that help track and improve app performance. We will not sell, rent, or lease your personal information to third parties without your consent.',
    },
    {
      'title': '5. Data Storage and Security',
      'body':
          'We take the security of your personal information seriously. Your data is stored on encrypted servers and third-party cloud services (e.g., AWS, Google Cloud).\nWe use encryption during transmission and at rest, and access to your data is limited to authorized personnel only.\nNote: As specified in Section 3, certain identity-verifying data such as the Date of Birth is locked once submitted to maintain the security of our membership and discount systems.',
    },
    {
      'title': '6. User Rights',
      'body':
          'You have certain rights regarding your personal information. You can:\n• Access and update your profile data (excluding birth date) via your account settings.\n• Request the deletion of your account and associated data.',
    },
    {
      'title': '7. Tracking Technologies',
      'body':
          'We may use tracking technologies such as Google Analytics to collect information about usage data. This helps us understand how users interact with our App and improve the user experience.',
    },
    {
      'title': "8. Children's Privacy",
      'body':
          'Our App is not intended for children under 13. We do not knowingly collect personal information from children under 13. If we become aware that we have collected such information, we will take steps to delete it.',
    },
    {
      'title': '9. Location of Operations',
      'body':
          'Our App is primarily used in Cambodia, and we comply with local regulations regarding data protection and privacy.',
    },
    {
      'title': '10. Contact Us',
      'body':
          'If you have any questions or concerns about this Privacy Policy, please contact us at externalshine@gmail.com.',
    },
    {
      'title': '11. Changes to This Privacy Policy',
      'body':
          'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the effective date.',
    },
  ];
}

class _PolicySection extends StatelessWidget {
  final String title;
  final String body;

  const _PolicySection({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2B2B2B),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF2B2B2B),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
