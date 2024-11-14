import 'package:flutter/material.dart';
import 'package:toma_scan/ui/pages/camera.dart';
import 'history_page.dart';
import 'profile_page.dart';
import 'informative_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TomaScan',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(),
      routes: {
        '/camera': (context) => const CameraPage(), // Daftarkan route kamera
        '/home': (context) => const HomePage(), // Daftarkan route home
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Daftar halaman yang sudah dibuat
  final List<Widget> _pages = [
    const HomeContent(), // Home content
    const InformativePage(), // Halaman Informative
    const HistoryPage(), // Halaman History
    const ProfilePage(), // Halaman Profile
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      // Navigasi ke halaman kamera dengan layar penuh
      Navigator.pushNamed(context, '/camera');
    } else {
      // Mengubah indeks yang dipilih jika bukan tombol kamera
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.eco, color: Colors.green),
            SizedBox(width: 8),
            Text(
              'TomaScan',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onItemTapped(2),
        backgroundColor: const Color(0xff00A86B),
        child: SvgPicture.asset(
          'assets/Scan.svg',
          semanticsLabel: 'My SVG Image',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                MaterialButton(
                  minWidth: 40,
                  onPressed: () => _onItemTapped(0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color: _selectedIndex == 0 ? Colors.green : Colors.grey,
                      ),
                      Text(
                        'Home',
                        style: TextStyle(
                            color: _selectedIndex == 0
                                ? Colors.green
                                : Colors.grey),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () => _onItemTapped(1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info,
                        color: _selectedIndex == 1 ? Colors.green : Colors.grey,
                      ),
                      Text(
                        'Informatif',
                        style: TextStyle(
                            color: _selectedIndex == 1
                                ? Colors.green
                                : Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                MaterialButton(
                  minWidth: 40,
                  onPressed: () => _onItemTapped(3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.history,
                        color: _selectedIndex == 3 ? Colors.green : Colors.grey,
                      ),
                      Text(
                        'History',
                        style: TextStyle(
                            color: _selectedIndex == 3
                                ? Colors.green
                                : Colors.grey),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () => _onItemTapped(4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color: _selectedIndex == 4 ? Colors.green : Colors.grey,
                      ),
                      Text(
                        'Profile',
                        style: TextStyle(
                            color: _selectedIndex == 4
                                ? Colors.green
                                : Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
