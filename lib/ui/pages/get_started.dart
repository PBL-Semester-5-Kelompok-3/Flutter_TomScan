// lib/widgets/social_login_button.dart
import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;
  final String iconPath;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;

  const SocialLoginButton({
    super.key,
    required this.text,
    required this.iconPath,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          minimumSize: const Size(double.infinity, 60),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              height: 24,
              width: 24,
            ),
            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// lib/widgets/custom_button.dart
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF00A884),
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          minimumSize: const Size(double.infinity, 50),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// lib/screens/login_screen.dart
class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Spacer(),
                Image.asset(
                  'assets/images/logo.png',
                  height: 80,
                  width: 80,
                ),
                const SizedBox(height: 40),
                const Text(
                  "Let's Get Started!",
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Let's dive in into your account",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey[600],
                  ),
                ),
                const Spacer(),
                SocialLoginButton(
                  text: 'Continue with Google',
                  iconPath: 'assets/icons/google.png',
                  onPressed: () {},
                ),
                SocialLoginButton(
                  text: 'Continue with Facebook',
                  iconPath: 'assets/icons/facebook.png',
                  onPressed: () {},
                ),
                const Spacer(),
                CustomButton(
                  backgroundColor: const Color(0xff00A86B),
                  textColor: const Color(0xffFFFFFF),
                  text: 'Sign up',
                  onPressed: () {
                    Navigator.pushNamed(context, '/sign-up');
                  },
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Log in',
                  backgroundColor: const Color(0xffEAF7F2),
                  textColor: const Color(0xFF00A86B),
                  onPressed: () {
                    Navigator.pushNamed(context, '/sign-in');
                  },
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/PrivacyPolicyPage');
                      },
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(
                            color: Colors.grey), // Menambahkan warna abu-abu
                      ),
                    ),
                    const Text(
                      '•',
                      style: TextStyle(
                          color: Colors.grey), // Menambahkan warna abu-abu
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/TermsPage');
                      },
                      child: Text(
                        'Terms of Service',
                        style: TextStyle(
                            color: Colors.grey), // Menambahkan warna abu-abu
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
