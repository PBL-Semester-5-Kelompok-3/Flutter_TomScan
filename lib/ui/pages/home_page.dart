import 'package:flutter/material.dart';
import 'package:toma_scan/ui/pages/widgets/bottom_nav_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/icon.png', // Ganti dengan path ikon 
              width: 30, // Sesuaikan ukuran ikon
              height: 30,
            ),
            SizedBox(width: 5), // Memberi jarak antara ikon dan teks
            Text(
              'TomaScan',
              style: TextStyle(
                fontSize: 20, // Sesuaikan ukuran teks
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: false, // Jika ingin teks rata kiri
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}