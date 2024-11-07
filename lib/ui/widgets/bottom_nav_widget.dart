import 'package:flutter/material.dart';

class BottomNavBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBarWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index == 0) {
          Navigator.pushNamed(context, '/home'); // Navigasi ke halaman History
        }
        if (index == 1) {
          Navigator.pushNamed(
              context, '/history'); // Navigasi ke halaman History
        }
        if (index == 4) {
          Navigator.pushNamed(
              context, '/profile'); // Navigasi ke halaman History
        }
        onTap(index); // Tetap panggil fungsi onTap eksternal
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.insert_drive_file_outlined), label: 'History'),
        BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_rounded), label: 'Scan'),
        BottomNavigationBarItem(
            icon: Icon(Icons.email_outlined), label: 'Informatif'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
      ],
    );
  }
}
