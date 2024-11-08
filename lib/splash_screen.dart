import 'dart:async'; // For Future.delayed
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  // Control for opacity and size animation
  double _logoSize = 100;
  double _logoOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _startAnimation(); // Start animation when splash screen loads

    // Navigate to the HomePage after 3 seconds, checking if widget is mounted
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // Check if widget is still in the widget tree
        Navigator.pushNamedAndRemoveUntil(
            context, '/onboarding_page', (route) => false);
      }
    });
  }

  // Start animation by setting new size and opacity values
  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _logoSize = 200; // Grow the logo size
        _logoOpacity = 1.0; // Fade in the logo
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green, // Splash screen background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 2), // Animation duration
              curve: Curves.easeInOut, // Smooth animation curve
              height: _logoSize,
              width: _logoSize,
              child: AnimatedOpacity(
                duration: const Duration(
                    seconds: 2), // Animation duration for opacity
                opacity: _logoOpacity,
                child: Image.asset(
                    'assets/icon.png'), // Replace with your app logo
              ),
            ),
            const SizedBox(height: 20), // Space between logo and text
            AnimatedOpacity(
              duration: const Duration(seconds: 2),
              opacity: _logoOpacity,
              child: const Text(
                'TomaScan',
                style: TextStyle(
                  fontSize: 30, // Font size for the text
                  fontWeight: FontWeight.bold, // Bold text
                  color: Colors.white, // Text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
