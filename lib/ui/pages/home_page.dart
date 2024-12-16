import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toma_scan/blocs/history/history_bloc.dart';
import 'package:toma_scan/blocs/history/history_state.dart';
import 'package:toma_scan/blocs/informative/informative_bloc.dart';
import 'package:toma_scan/models/history_model.dart';
import 'package:toma_scan/services/history_service.dart';
import 'package:toma_scan/services/informatif_service.dart';
import 'package:toma_scan/ui/pages/camera.dart';
import 'package:toma_scan/ui/pages/popular_article_page.dart';
import 'package:toma_scan/ui/pages/view_article.dart';
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

  void _onItemTapped(int index) async {
    final cameras = await availableCameras();
    if (index == 2) {
      // Navigasi ke halaman kamera dengan layar penuh
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CameraApp(cameras: cameras),
        ),
      );
    } else {
      // Mengubah indeks yang dipilih jika bukan tombol kamera
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              InformativeBloc(InformatifsService())..add(FetchInformatives()),
        ),
      ],
      child: Scaffold(
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
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.notifications, color: Colors.grey),
          //     onPressed: () {
          //       Navigator.pushNamed(context, '/notification');
          //     },
          //   ),
          // ],
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          }, context),
          _buildPopularArticles(),
          _buildSectionHeader('Last Detection', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HistoryPage(),
              ),
            );
          }, context),
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

  Widget _buildSectionHeader(
      String title, VoidCallback onViewAll, BuildContext context) {
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
            // onTap: onViewAll,
            onTap: () {
              if (title == 'Popular Article') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PopularArticlePage(),
                  ),
                );
              } else if (title == 'Last Detection') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HistoryPage(),
                  ),
                );
              }
            },
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
    return BlocBuilder<InformativeBloc, InformativeState>(
      builder: (context, state) {
        if (state is InformativeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is InformativeSuccess) {
          final informatifs =
              state.informatives.take(3).toList(); // Batasi 3 artikel
          return SizedBox(
            height: 180, // Tinggi elemen
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: informatifs.length,
              itemBuilder: (context, index) {
                final article = informatifs[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewArticle(
                          title: article.title,
                          tag: article.type,
                          imageUrl: article.image,
                          content: article.content,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 160, // Lebar elemen
                    margin: EdgeInsets.only(
                      left: index == 0 ? 16 : 8,
                      right: index == informatifs.length - 1 ? 16 : 0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.network(
                            article.image,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            article.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is InformativeError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return const Center(child: Text('No popular articles available.'));
      },
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
    return FutureBuilder<List<History>>(
      future: fetchDetections(), // Replace with your data-fetching method
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No recent detections found.'));
        } else {
          final detections = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: detections.length,
            itemBuilder: (context, index) {
              final detection = detections[index];
              return _buildDetectionItem(
                context,
                date: detection.createdAt.toString(),
                imageUrl: detection.imagePath,
                title: detection.disease,
                description: detection.schedule.isNotEmpty
                    ? detection.schedule[0].description
                    : 'No description available',
                history: detection,
              );
            },
          );
        }
      },
    );
  }

  Future<List<History>> fetchDetections() async {
    try {
      final historyService =
          HistoryService(baseUrl: 'https://tomascan.nurulmustofa.my.id');
      final allHistories = await historyService.getAllHistories();

      // Sort and take the latest 3 detections
      allHistories.sort((a, b) =>
          b.createdAt.compareTo(a.createdAt)); // Sort by date descending
      return allHistories.take(3).toList(); // Take only the latest 3
    } catch (error) {
      throw Exception('Failed to fetch detections: $error');
    }
  }

  Widget _buildDetectionItem(
    BuildContext context, {
    required String date,
    required String imageUrl,
    required String title,
    required String description,
    required History history,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailHistoryPage(
              title: history.disease,
              imageUrl: history.imagePath,
              disease: history.disease,
              schedule: history.schedule,
              solutions: history.solutions,
              pests: history.pest,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display detection image
              Image.network(
                imageUrl,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 8),

              // Title and description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),

              // Chevron icon for navigation
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
          const Divider(height: 32),
        ],
      ),
    );
  }
}
