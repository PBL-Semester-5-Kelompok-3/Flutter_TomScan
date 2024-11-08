import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icon2.png', // Pastikan path ini sesuai dengan lokasi file gambar
          width: 24,
          height: 24,
        ),
        const SizedBox(width: 8),
        const Text(
          "TomaScan",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
