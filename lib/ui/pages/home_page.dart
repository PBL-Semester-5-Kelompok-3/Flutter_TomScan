import 'package:flutter/material.dart';
import 'history_page.dart';
import 'identify_leaf_page.dart';
import 'profile_page.dart';
import 'informative_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Daftar halaman yang sudah dibuat
  final List<Widget> _pages = [
    HomeContent(), // Home content
    InformativePage(), // Halaman Informative
    IdentifyLeafPage(), // Halaman Identify Leaf
    HistoryPage(), // Halaman History
    ProfilePage(), // Halaman Profile
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
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
            icon: Icon(Icons.notifications, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: _selectedIndex == 0 ? Colors.green : Colors.grey),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info,
                color: _selectedIndex == 1 ? Colors.green : Colors.grey),
            label: 'Informative',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _selectedIndex == 2 ? Colors.green : Colors.grey,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.camera_alt, color: Colors.white),
            ),
            label: 'Identify Leaf',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history,
                color: _selectedIndex == 3 ? Colors.green : Colors.grey),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: _selectedIndex == 4 ? Colors.green : Colors.grey),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Content for the Home tab as a placeholder
class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStep(Icons.camera_alt, 'Take a picture'),
                Icon(Icons.arrow_forward, color: Colors.grey),
                _buildStep(Icons.mobile_friendly, 'See Diagnosis'),
                Icon(Icons.arrow_forward, color: Colors.grey),
                _buildStep(Icons.local_pharmacy, 'Get Medicine'),
              ],
            ),
          ),
          _buildSectionHeader('Popular Article', () {}),
          _buildPopularArticles(),
          _buildSectionHeader('Last Detection', () {}),
          _buildLastDetections(),
        ],
      ),
    );
  }

  Widget _buildStep(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.green, size: 32),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(color: Colors.green, fontSize: 12),
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
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: onViewAll,
            child: Text(
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
          SizedBox(width: 16),
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
          SizedBox(height: 8),
          Text(
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
