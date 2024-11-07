import 'package:flutter/material.dart';
import 'package:toma_scan/ui/pages/home_page.dart';
import 'package:toma_scan/ui/pages/onboarding_page.dart';
import 'splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TomaScan',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomePage(),
        '/onboarding_page': (context) => const OnboardingPage(),
      },
    );
  }
}
