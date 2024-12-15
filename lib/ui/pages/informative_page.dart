import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toma_scan/blocs/informative/informative_bloc.dart';
import 'package:toma_scan/blocs/PestAndDisease/pestanddisease_bloc.dart';
import 'package:toma_scan/services/informatif_service.dart';
import 'package:toma_scan/ui/pages/pests_desease_page.dart';
import 'package:toma_scan/ui/pages/popular_article_page.dart';
import 'package:toma_scan/ui/pages/view_article.dart';
import 'package:toma_scan/ui/pages/view_pests.dart';

class InformativePage extends StatelessWidget {
  const InformativePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              InformativeBloc(InformatifsService())..add(FetchInformatives()),
        ),
        BlocProvider(
          create: (context) => PestAndDiseaseBloc(InformatifsService())
            ..add(FetchPestAndDiseases()),
        ),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<InformativeBloc, InformativeState>(
                builder: (context, state) {
                  if (state is InformativeLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is InformativeSuccess) {
                    final informatifs = state.informatives;

                    return ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        SectionHeader(
                          title: 'Article Populer',
                          onViewAll: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PopularArticlePage()), // Halaman baru untuk melihat semua artikel
                            );
                          },
                        ),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 2,
                          ),
                          itemCount: informatifs.length,
                          itemBuilder: (context, index) => ArticleCard(
                            imageUrl: informatifs[index].image,
                            title: informatifs[index].title,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewArticle(
                                  title: informatifs[index].title,
                                  tag: informatifs[index].type,
                                  imageUrl: informatifs[index].image,
                                  content: informatifs[index].content,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state is InformativeError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else {
                    return const Center(child: Text('No data found'));
                  }
                },
              ),
              BlocBuilder<PestAndDiseaseBloc, PestAndDiseaseState>(
                builder: (context, state) {
                  if (state is PestAndDiseaseLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PestAndDiseaseSuccess) {
                    final pestsDeseases = state.pestAndDiseases;
                    return ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        SectionHeader(
                          title: 'Pests and Diseases',
                          onViewAll: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PestsDeseasePage()), // Halaman baru untuk melihat semua artikel
                            );
                          },
                        ),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 2,
                          ),
                          itemCount: pestsDeseases.length,
                          itemBuilder: (context, index) => ArticleCard(
                            imageUrl: pestsDeseases[index].source,
                            title: pestsDeseases[index].name,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewPests(
                                  name: pestsDeseases[index].name,
                                  description: pestsDeseases[index].description,
                                  warning: pestsDeseases[index].warning,
                                  genus: pestsDeseases[index].genus,
                                  scientificName:
                                      pestsDeseases[index].scientificName,
                                  aliases: pestsDeseases[index].aliases,
                                  symptoms: pestsDeseases[index].symptoms,
                                  solutions: pestsDeseases[index].solutions,
                                  source: pestsDeseases[index].source,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state is PestAndDiseaseError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else {
                    return const Center(child: Text('No data found'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;

  const SectionHeader(
      {super.key, required this.title, required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Row(
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
            style: TextStyle(fontSize: 14, color: Colors.green),
          ),
        ),
      ],
    );
  }
}

class ArticleCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onTap; // Tambahkan parameter onTap

  const ArticleCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onTap, // Tambahkan required parameter
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Wrap dengan GestureDetector
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.75),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}

class EducationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap; // Tambahkan parameter onTap

  const EducationCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap, // Tambahkan required parameter
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Wrap dengan GestureDetector
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.green),
            const SizedBox(width: 4),
            Text(
              title,
              style: const TextStyle(color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:toma_scan/blocs/informative/informative_bloc.dart';
// import 'package:toma_scan/models/informatifs_model.dart';
// import 'package:toma_scan/services/informatif_service.dart';
// import 'package:toma_scan/ui/pages/popular_article_page.dart';
// import 'package:toma_scan/ui/pages/view_article.dart';
// import 'history_page.dart';
// import 'profile_page.dart';
// import 'informative_page.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   HomePageState createState() => HomePageState();
// }

// class HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;

//   // Daftar halaman yang sudah dibuat
//   final List<Widget> _pages = [
//     const HomeContent(), // Home content
//     const InformativePage(), // Halaman Informative
//     const HistoryPage(), // Halaman History
//     const HistoryPage(), // Halaman History
//     const ProfilePage(), // Halaman Profile
//   ];

//   void _onItemTapped(int index) {
//     if (index == 2) {
//       // Navigasi ke halaman kamera dengan layar penuh
//       Navigator.pushNamed(context, '/camera');
//     } else {
//       // Mengubah indeks yang dipilih jika bukan tombol kamera
//       setState(() {
//         _selectedIndex = index;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) =>
//           InformativeBloc(InformatifsService())..add(FetchInformatives()),
//       child: Scaffold(
//         backgroundColor: Colors.grey[50],
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           title: const Row(
//             children: [
//               Icon(Icons.eco, color: Colors.green),
//               SizedBox(width: 8),
//               Text(
//                 'TomaScan',
//                 style: TextStyle(color: Colors.black),
//               ),
//             ],
//           ),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.notifications, color: Colors.grey),
//               onPressed: () {
//                 Navigator.pushNamed(context, '/notification');
//               },
//             ),
//           ],
//         ),
//         body: _pages[_selectedIndex],
//         floatingActionButton: Container(
//           padding: const EdgeInsets.only(bottom: 0.1),
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(
//               color: const Color(0xFF00E526), // Stroke color
//               width: 5.0, // Stroke width
//             ),
//           ),
//           child: FloatingActionButton(
//             onPressed: () => _onItemTapped(2),
//             shape: const CircleBorder(),
//             backgroundColor: const Color(0xff00A86B),
//             elevation: 2, // Adjust elevation as needed
//             child: SvgPicture.asset(
//               'assets/Scan.svg',
//               semanticsLabel: 'My SVG Image',
//             ),
//           ),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         bottomNavigationBar: BottomAppBar(
//           shape: const CircularNotchedRectangle(),
//           notchMargin: 8,
//           height: 70,
//           child: SizedBox(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     MaterialButton(
//                       minWidth: 40,
//                       onPressed: () => _onItemTapped(0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.home,
//                             color: _selectedIndex == 0
//                                 ? Colors.green
//                                 : Colors.grey,
//                             size: 20,
//                           ),
//                           Text(
//                             'Home',
//                             style: TextStyle(
//                               color: _selectedIndex == 0
//                                   ? Colors.green
//                                   : Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     MaterialButton(
//                       minWidth: 40,
//                       onPressed: () => _onItemTapped(1),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.info,
//                             color: _selectedIndex == 1
//                                 ? Colors.green
//                                 : Colors.grey,
//                             size: 20,
//                           ),
//                           Text(
//                             'Informatif',
//                             style: TextStyle(
//                               color: _selectedIndex == 1
//                                   ? Colors.green
//                                   : Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     MaterialButton(
//                       minWidth: 40,
//                       onPressed: () => _onItemTapped(3),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.history,
//                             color: _selectedIndex == 3
//                                 ? Colors.green
//                                 : Colors.grey,
//                             size: 20,
//                           ),
//                           Text(
//                             'History',
//                             style: TextStyle(
//                               color: _selectedIndex == 3
//                                   ? Colors.green
//                                   : Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     MaterialButton(
//                       minWidth: 40,
//                       onPressed: () => _onItemTapped(4),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.person,
//                             color: _selectedIndex == 4
//                                 ? Colors.green
//                                 : Colors.grey,
//                             size: 20,
//                           ),
//                           Text(
//                             'Profile',
//                             style: TextStyle(
//                               color: _selectedIndex == 4
//                                   ? Colors.green
//                                   : Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Content for the Home tab as a placeholder
// class HomeContent extends StatelessWidget {
//   const HomeContent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Container(
//             margin: const EdgeInsets.all(16),
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.green[50],
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildStep(Icons.camera_alt, 'Take a picture'),
//                 const Icon(Icons.arrow_forward, color: Colors.grey),
//                 _buildStep(Icons.mobile_friendly, 'See Diagnosis'),
//                 const Icon(Icons.arrow_forward, color: Colors.grey),
//                 _buildStep(Icons.local_pharmacy, 'Get Medicine'),
//               ],
//             ),
//           ),
//           _buildSectionHeader('Popular Article', () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const PopularArticlePage(),
//               ),
//             );
//           }),
//           BlocBuilder<InformativeBloc, InformativeState>(
//             builder: (context, state) {
//               if (state is InformativeLoading) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (state is InformativeSuccess) {
//                 final informatifs = state.informatives;
//                 return ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: informatifs.length,
//                   itemBuilder: (context, index) {
//                     final article = informatifs[index];
//                     return ListTile(
//                       title: Text(article.title ?? 'No Title'),
//                       subtitle: Text(article.type ?? 'No Summary'),
//                       onTap: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ViewArticle(
//                             title: informatifs[index].title,
//                             tag: informatifs[index].type,
//                             imageUrl: informatifs[index].image,
//                             content: informatifs[index].content,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               } else if (state is InformativeError) {
//                 return Center(child: Text(state.message));
//               }
//               return const SizedBox();
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStep(IconData icon, String text) {
//     return Column(
//       children: [
//         Icon(icon, color: Colors.green, size: 30),
//         const SizedBox(height: 4),
//         Text(text, style: const TextStyle(fontSize: 12)),
//       ],
//     );
//   }

//   Widget _buildSectionHeader(String title, VoidCallback onTap) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 16),
//       child: ListTile(
//         title: Text(title,
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         trailing: const Icon(Icons.arrow_forward),
//         onTap: onTap,
//       ),
//     );
//   }
// }