import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
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
        SizedBox(width: 8),
        Text(
          "TomaScan",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
