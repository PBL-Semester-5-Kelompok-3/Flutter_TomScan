import 'package:flutter/material.dart';
import 'package:toma_scan/ui/pages/popular_article_page.dart';
import 'history_page.dart';
// import 'identify_leaf_page.dart';
import 'profile_page.dart';
import 'informative_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Daftar halaman yang sudah dibuat
  final List<Widget> _pages = [
    const HomeContent(), // Home content
    const InformativePage(), // Halaman Informative
    const HistoryPage(), // Halaman History
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
        floatingActionButton: Container(
          padding: const EdgeInsets.only(bottom: 0.1),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF00E526), // Stroke color
              width: 5.0, // Stroke width
            ),
          ),
          child: FloatingActionButton(
            onPressed: () => _onItemTapped(2),
            shape: const CircleBorder(),
            backgroundColor: const Color(0xff00A86B),
            elevation: 2, // Adjust elevation as needed
            // child: const Icon(Icons.camera_alt, color: Colors.white),
            child: SvgPicture.asset(
              'assets/Scan.svg',
              semanticsLabel: 'My SVG Image',
              // height: 100,
              // width: 70,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          height: 70,
          child: SizedBox(
            // height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () => _onItemTapped(0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home,
                            color: _selectedIndex == 0
                                ? Colors.green
                                : Colors.grey,
                            size: 20,
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
                            color: _selectedIndex == 1
                                ? Colors.green
                                : Colors.grey,
                            size: 20,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () => _onItemTapped(3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.history,
                            color: _selectedIndex == 3
                                ? Colors.green
                                : Colors.grey,
                            size: 20,
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
                            color: _selectedIndex == 4
                                ? Colors.green
                                : Colors.grey,
                            size: 20,
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
        ),
      ),
    );
  }
}

// Content for the Home tab as a placeholder
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStep(Icons.camera_alt, 'Take a picture'),
                const Icon(Icons.arrow_forward, color: Colors.grey),
                _buildStep(Icons.mobile_friendly, 'See Diagnosis'),
                const Icon(Icons.arrow_forward, color: Colors.grey),
                _buildStep(Icons.local_pharmacy, 'Get Medicine'),
              ],
            ),
          ),
          _buildSectionHeader('Popular Article', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PopularArticlePage(),
              ),
            );
          }),
          _buildPopularArticles(),
          _buildSectionHeader('Last Detection', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HistoryPage(),
              ),
            );
          }),
          _buildLastDetections(),
        ],
      ),
    );
  }

  Widget _buildStep(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.green, size: 32),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.green, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onViewAll) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: onViewAll,
            child: const Text(
              'View all',
              style: TextStyle(color: Colors.green, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularArticles() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildArticleCard(),
          const SizedBox(width: 16),
          _buildArticleCard(),
        ],
      ),
    );
  }

  Widget _buildArticleCard() {
    return Expanded(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://th.bing.com/th/id/OIP.HiwZb7pY_PaooR59RRIHBgHaGK?w=239&h=198&c=7&r=0&o=5&dpr=1.9&pid=1.7',
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Croatia doubles tomato production with Podravka\'s...',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildLastDetections() {
    return Column(
      children: List.generate(3, (index) => _buildDetectionItem()),
    );
  }

  Widget _buildDetectionItem() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(
                'https://i5.walmartimages.com/asr/9f8b7456-81d0-4dc2-b422-97cf63077762.0ddba51bbf14a5029ce82f5fce878dee.jpeg'),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Water Your Tomatoes today',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'It\'s 2 weeks old, you have to water it twice a w...',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}
