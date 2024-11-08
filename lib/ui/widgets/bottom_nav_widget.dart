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
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index == 0) {
          Navigator.pushNamed(context, '/home'); // Navigasi ke halaman Home
        }
        if (index == 1) {
          Navigator.pushNamed(
              context, '/informative'); // Navigasi ke halaman Informative
        }
        if (index == 2) {
          Navigator.pushNamed(
              context, '/identify'); // Navigasi ke halaman Identify Leaf
        }
        if (index == 3) {
          Navigator.pushNamed(
              context, '/history'); // Navigasi ke halaman History
        }
        if (index == 4) {
          Navigator.pushNamed(
              context, '/profile'); // Navigasi ke halaman Profile
        }
        onTap(index); // Tetap panggil fungsi onTap eksternal
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.info_outline), label: 'Informative'),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(Icons.qr_code_scanner_rounded, color: Colors.white),
          ),
          label: 'Identify Leaf',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
